import 'package:flutter/material.dart';
import 'package:oyw/client/routes/router.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final List _drawerMenu = [
      {
        "icon": Icons.restore,
        "text": "My rides",
        "route": MyRidesRoute,
      },
      {
        "icon": Icons.local_activity,
        "text": "Promotions",
        "routes": PromotionRoute
      },
      {
        "icon": Icons.star_border,
        "text": "My Favourites",
        "route": FavoritesRoute
      },
      {
        "icon": Icons.credit_card,
        "text": "My Payments",
        "route": PaymentRoute,
      },
      {
        "icon": Icons.notifications,
        "text": "Notification",
      },
      {
        "icon": Icons.chat,
        "text": "Support",
        "route": ChatRiderRoute,
      },
    ];
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.2),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              height: 170.0,
              color: _theme.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/77093500_190531721993456_4302710628113448960_o.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_oc=AQn6CG8do_8dBovgBGDe7UGESSyQ4HJHM4NDIG57NkrLin00RNLfjQ3zIvT9RIZqD38&_nc_ht=scontent.fktm7-1.fna&oh=52bd7bea1b4c0962d78e2ef4fb34026d&oe=5EA2660C"),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Samujjwal Pandey",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProfileRoute);
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "444-509-980-103",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 15.0,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: ListView(
                  children: _drawerMenu.map((menu) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(menu["route"]);
                      },
                      child: ListTile(
                        leading: Icon(menu["icon"]),
                        title: Text(
                          menu["text"],
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
