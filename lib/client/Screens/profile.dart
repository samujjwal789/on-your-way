import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyw/client/styles/colors.dart';
import 'package:oyw/client/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:oyw/client/providers/auth_provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context);
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.times),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hello Samujjwal!",
                  style:
                      _theme.textTheme.title.merge(TextStyle(fontSize: 26.0)),
                ),
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://scontent.fktm7-1.fna.fbcdn.net/v/t1.0-9/77093500_190531721993456_4302710628113448960_o.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_oc=AQn6CG8do_8dBovgBGDe7UGESSyQ4HJHM4NDIG57NkrLin00RNLfjQ3zIvT9RIZqD38&_nc_ht=scontent.fktm7-1.fna&oh=52bd7bea1b4c0962d78e2ef4fb34026d&oe=5EA2660C"),
                )
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            CustomTextFormField(
              hintText: "Name",
              value: "Samujjwal Pandey",
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextFormField(
              hintText: "Email",
              value: "samujjwalpandey@gmail.com",
              suffixIcon: Icon(
                Icons.check_circle,
                color: _theme.primaryColor,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            CustomTextFormField(
              hintText: "Phone Number",
              value: "444-509-980-103",
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "PREFERENCES",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                color: Color(0xFF9CA4AA),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFBFBFD),
                border: Border.all(
                  color: Color(0xffD6D6D6),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "RECEIVE RECEIPT MAILS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Switch(
                        value: true,
                        activeColor: _theme.primaryColor,
                        onChanged: (bool state) {},
                      )
                    ],
                  ),
                  Text(
                    "The switch is the widget used to achieve the popular.",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFBFBFD),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "SOCIAL NETWORK",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Color(0xFF9CA4AA),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 45.0,
                    child: FlatButton(
                        onPressed: () {
                          user.signOut();
                        },
                        color: facebookColor,
                        child: Text("LogOut")),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 45.0,
                    child: FlatButton(
                      onPressed: () {},
                      color: facebookColor,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.facebookSquare,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Text(
                              "Connect with Facebook",
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.body1.merge(
                                TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: _theme.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(3.0)),
                    margin: EdgeInsets.only(top: 10.0),
                    height: 45.0,
                    child: FlatButton(
                      onPressed: () {},
                      color: _theme.scaffoldBackgroundColor,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            size: 18.0,
                            color: _theme.primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              "Connect with Google",
                              textAlign: TextAlign.center,
                              style: _theme.textTheme.body1.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
