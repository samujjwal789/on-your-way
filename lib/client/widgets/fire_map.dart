import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  BehaviorSubject<String> docRxId = BehaviorSubject.seeded("NotFound");
  GoogleMapController mapsController;

  Completer<GoogleMapController> mapController = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  MarkerId marker_id_1;

  int _markerIdCounter = 1;
  static final LatLng center = const LatLng(-33.86711, 151.1947171);
  static final LatLng centerpos = const LatLng(-33.86711, 151.1947171);
  //Polyline
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 1;
  PolylineId selectedPolyline;
  //Location
  LocationData _startLocation;
  LocationData _currentLocation;
  CameraPosition _currentCameraPosition;

  StreamSubscription<LocationData> _locationSubscription;
  LatLng _lastMapPosition = center;

  Location _locationService = new Location();
  PermissionStatus _permission;
  String error;

  //Firestore
  Firestore firestore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  //GeoFireStore
  Stream<dynamic> query;
  StreamSubscription subscription;
  StreamSubscription routeSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _startQuery();
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    subscription.cancel();
    routeSubscription.cancel();
    super.dispose();
  }

  var initilize = false;
  DocumentReference docRef;
  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.high, interval: 10000);
    LocationData location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission == PermissionStatus.granted) {
          location = await _locationService.getLocation();
          print("Location called");
          //Stream of data
          _locationSubscription = _locationService.onLocationChanged
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);

            if (!initilize) {
              final GoogleMapController controller = await mapController.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(_currentCameraPosition));
            }
            LatLng _currentLatLngLocation;
            if (mounted) {
              setState(() {
                debugPrint(
                    "Current location = ${result.latitude} ${result.longitude}");
                _currentLocation = result;
                _currentLatLngLocation =
                    LatLng(result.latitude, result.longitude);
              });

              if (!initilize) {
                _add(_currentLatLngLocation);
                print("First Time Current Location has been Added");
                setState(() {
                  initilize = true;
                });
                docRef = await _addGeoPoint(_currentLatLngLocation);
                setState(() {
                  docRxId.add(docRef.documentID.toString());
                });
                print("DocRef ---------===== ${docRef.documentID}");
              } else {
                if (_currentLatLngLocation != null) {
                  _updateGeoPoint(_currentLatLngLocation);
                  _addPolyline(_currentLatLngLocation);
                  _addGeoPolyline(_currentLatLngLocation);
                }
              }
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      print("Start Location = $location");
      _startLocation = location;
    });
  }

  _startQuery() async {
    var ref = firestore.collection('locations');
    print("Start Query running");
    // subscribe to query
      double radius = 1000;
      GeoFirePoint geoCenter = geo.point(latitude: center.latitude, longitude: center.longitude);
      subscription =
          geo.collection(collectionRef: ref).within(center: geoCenter, radius: radius, field: 'position').listen(_updateMarkers);
      routeSubscription = docRxId
          .switchMap((docId) {
            return firestore
                .collection('routes')
                .document(docId)
                .collection('position')
                .snapshots();
          })
          .asBroadcastStream()
          .listen(_getRoute);
  }

  Future<DocumentReference> _addGeoPoint(LatLng pos) async {
    print("Add Geo Point Called initilize");
    GeoFirePoint point = GeoFirePoint(pos.latitude, pos.longitude);
    DocumentReference testRef =
        firestore.collection('locations').document('test');

    testRef.setData({'position': point.data, 'name': 'Yay I can be queried!'});
    return testRef;
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print("UpdateMarkers Called");
    // mapController.clearMarkers();
    clearMarkers();
    documentList.forEach((DocumentSnapshot document) {
      print(
          "Document +++++++++++++++++++++++++++++++++++++ ${document.data}  ${document.data['position']['geopoint'].latitude}");
      GeoPoint pos = document.data['position']['geopoint'];
      // double distance = document.data['distance'];
      var position = LatLng(pos.latitude, pos.longitude);
      _add(position);
    });
  }

  //Flutter Polyline
  void _addPolyline(LatLng position) {
    final int polylineCount = polylines.length;

    final String polylineIdVal = 'polyline_id_$_polylineIdCounter';
    _polylineIdCounter++;
    final PolylineId polylineId = PolylineId("trakerLocation");

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.orange,
      width: 5,
      points: _createPoints(),
      onTap: () {
        // _onPolylineTapped(polylineId);
      },
    );

    setState(() {
      print("Add Polyline Called ${_lastMapPosition.latitude}");
      points.add(_createLatLng(position.latitude, position.longitude));
      polylines[polylineId] = polyline;
    });
  }

  int token = 0;
  Future _updateGeoPoint(LatLng location) async {
    print("Update Geo Point Running $token");
    LatLng pos = location != null ? location : center;
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    setState(() {
      token++;
    });
    if (docRef != null) {
      docRef.setData({'position': point.data, 'name': 'Data Updated $token'});
    }
  }

  Future<DocumentReference> _addGeoPolyline(_currentLatLngLocation) {
    LatLng position = _currentLatLngLocation;
    docRxId.stream.listen((data) {
      print("DocRxId $data");
    });
    // GeoFirePoint route = geo.point(
    //     latitude: position.latitude,
    //     longitude: position.longitude);
    var docId = docRef.documentID.toString();
    print("add geo polyline $docId");
    return firestore
        .collection('routes')
        .document(docId)
        .collection("position")
        .add({
      'position': {
        'latitude': position.latitude,
        'longitude': position.longitude
      }
    });
  }

  void _getRoute(QuerySnapshot snapshot) {
    print("Get Route Called");
    if (docRef != null) {
      var docId = docRef.documentID.toString();
      firestore
          .collection("routes")
          .document(docId)
          .collection('position')
          .getDocuments()
          .then((querySnapshot) {
        print("get Route is still Running ${querySnapshot.documents.length}");
        setState(() {
          points = <LatLng>[];
        });
        List<LatLng> newPoints = [];
        querySnapshot.documents.forEach((doc) {
          print("Document Id  of Route ${doc.data['position']}");
          var position = doc.data['position'];
          // _addPolyline(LatLng(position['latitude'], position['longitude']));
          newPoints.add(LatLng(position['latitude'], position['longitude']));
        });
        setState(() {
          points = newPoints;
        });
      });
    }
  }

  List<LatLng> points = <LatLng>[];
  List<LatLng> _createPoints() {
    final double offset = _polylineIdCounter.ceilToDouble();
    return points;
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  void _add(LatLng current) {
    final int markerCount = markers.length;
    print(markerCount);
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: current,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void clearMarkers() {
    Marker currentMarker = markers['marker_id_1'];
    print('currentMarker $currentMarker $markers');
    setState(() {
      markers = <MarkerId, Marker>{};
      // markers[marker_id_1] = currentMarker;
      _markerIdCounter = 1;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-33.852, 151.211),
          zoom: 11.0,
        ),
        polylines: Set<Polyline>.of(polylines.values),
        myLocationEnabled: true,
        onCameraMove: _onCameraMove,
        markers: Set<Marker>.of(markers.values),
      ),
      Positioned(
          bottom: 50,
          right: 10,
          child: FlatButton(
              child: Icon(Icons.pin_drop),
              color: Colors.green,
              onPressed: () {
                print("Onpressed Called");
                _add(_lastMapPosition);
                // _addPolyline(_currentLocation);
                // _addGeoPolyline();
              }))
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      print("On Map Created");
      // mapController = controller;
      mapController.complete(controller);
    });
  }
}
