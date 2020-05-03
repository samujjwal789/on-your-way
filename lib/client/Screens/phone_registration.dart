import 'package:flutter/material.dart';
import 'package:oyw/client/routes/router.dart';
import 'package:oyw/client/widgets/custom_text_form_field.dart';

class PhoneRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "What is your phone number?",
                      style: _theme.textTheme.title.merge(
                        TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  Text(
                    "Tap \"Get Started\" to get an SMS confirmation to help you use OYW. We would like to get your phone number.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: CustomTextFormField(
                          hintText: "+977",
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          hintText: "Country Code",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: FlatButton(
                color: _theme.primaryColor,
                child: Text(
                  "GET STARTED",
                  style: _theme.textTheme.body1.merge(
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(HomepageRoute);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
