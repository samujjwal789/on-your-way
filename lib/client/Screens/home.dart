import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oyw/client/widgets/app_drawer.dart';
import 'package:oyw/client/widgets/fire_map.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng myLocation;
  List<Marker> _markers = [
    Marker(
      width: 60.0,
      height: 60.0,
      point: LatLng(85.3240, 27.7172),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/bike.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    ),
    Marker(
      width: 60.0,
      height: 60.0,
      point: LatLng(51.3, -0.08),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/bike.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    ),
    Marker(
      width: 60.0,
      height: 60.0,
      point: LatLng(51.29, -0.077),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/bike.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    )
  ];
  @override
  void initState() {
    super.initState();
    getMyLocation();
  }

  Future<void> getMyLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    myLocation = LatLng(position.latitude, position.longitude);
    this.setState(() {
      _markers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: myLocation,
          builder: (ctx) => Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                  child: Icon(Icons.person_pin_circle),
                ),
                Container(
                  child: Text("Pick Up Here"),
                )
              ],
            ),
          ),
        ),
      );
    });
    print(position);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 230.0,
                  // child: GoogleMap(
                  //   myLocationButtonEnabled: true,
                  //   myLocationEnabled: true,
                  //   markers: _markers,
                  //   onMapCreated: _onMapCreated,
                  //   initialCameraPosition: CameraPosition(
                  //     target: _center,
                  //     zoom: 11.0,
                  //   ),
                  // ),
                  child: FireMap(),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.menu,
                        size: 35.0,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(
                        0,
                        0,
                        0,
                        0.15,
                      ),
                      blurRadius: 25.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Where you wanna send?",
                      style: _theme.textTheme.title,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Book on demand or pre-scheduled rides",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Hero(
                        tag: "search",
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Enter Destination",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.search,
                                color: _theme.primaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
