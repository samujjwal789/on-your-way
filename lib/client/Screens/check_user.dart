import 'package:flutter/material.dart';
import 'package:oyw/client/providers/auth_provider.dart';
import 'package:oyw/client/Screens/onboarding.dart';
import 'package:oyw/client/Screens/login.dart';
import 'package:oyw/client/Screens/home.dart';
import 'package:provider/provider.dart';

class CheckUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthProvider user, _) {
        print("Notify listener called.");
        switch (user.status) {
          case Status.Uninitialized:
            return Onboarding();
          case Status.Unauthenticated:
            return Onboarding();
          case Status.Authenticating:
            return Login();
          case Status.Authenticated:
            return HomePage();
          default:
            return Onboarding();
        }
      },
    );
  }
}
