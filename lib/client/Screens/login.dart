import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyw/client/Screens/phone_registration.dart';
import 'package:oyw/client/routes/router.dart';
import 'package:oyw/client/styles/colors.dart';
import 'package:oyw/client/widgets/custom_text_form_field.dart';
import 'package:oyw/client/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: _theme.primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Log In",
                      style: _theme.textTheme.title.merge(
                        TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // _loginForm(context),
                  LoginForm()
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Or connect using social account",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneRegistration()));
                      },
                      color: _theme.scaffoldBackgroundColor,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            color: _theme.primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              "Connect with Phone number",
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
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email;
  String password;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  void handleEmail(value) {
    print("handleChanged ");
    setState(() {
      email = value;
    });
    print(email);
  }

  void handlePassword(value) {
    setState(() {
      password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    final ThemeData _theme = Theme.of(context);
    return user.status == Status.Authenticating
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (error != "") ? Text("Login error.") : Container(),
                CustomTextFormField(
                    onChange: handleEmail,
                    hintText: "Email",
                    validator: (value) {
                      print("Validator called");
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  onChange: handlePassword,
                  validator: (value) {
                    print("Password Validator called");
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  hintText: "Password",
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: _theme.primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45.0,
                  child: FlatButton(
                    color: _theme.primaryColor,
                    // onPressed: () {
                    //   Navigator.of(context).pushReplacementNamed(HomepageRoute);
                    // },
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (!await user.signIn(email, password)) {
                          print("Unable to login ---------");
                          // setState(() {
                          //   error = "Unable to login";
                          // });
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Something is wrong"),
                          ));
                        } else {
                          Navigator.of(context)
                              .pushReplacementNamed(HomepageRoute);
                        }
                      }
                    },
                    child: Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
