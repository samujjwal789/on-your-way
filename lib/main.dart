import 'package:flutter/material.dart';
import 'package:oyw/client/providers/onboarding_provider.dart';
import 'package:oyw/client/routes/router.dart';
import 'package:provider/provider.dart';
import 'client/styles/theme_data.dart';
import 'package:oyw/client/providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (BuildContext context) => OnboardingProvider(),
        child: ChangeNotifierProvider(
          create: (_) => AuthProvider.instance(),
          child: Consumer(
            builder: (context, AuthProvider user, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: onGenerateRoute,
                theme: ThemeScheme.light(),
                initialRoute: CheckUserRoute,
              );
            },
          ),
        )),
  );
}
