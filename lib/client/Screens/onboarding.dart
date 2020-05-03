import 'package:flutter/material.dart';
import 'package:oyw/client/providers/onboarding_provider.dart';
import 'package:oyw/client/routes/router.dart';
import 'package:oyw/client/widgets/onboarding_stepper.dart';
import 'package:oyw/client/widgets/onboarding_template.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatelessWidget {
  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final OnboardingProvider _onboardingProvider =
        Provider.of<OnboardingProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: PageView(
              controller: _pageViewController,
              onPageChanged: (int index) {
                _onboardingProvider.onPageChange(index);
              },
              children: <Widget>[
                OnboardingTemplate(
                  title: "Pay with your moblie",
                  subtitle:
                      "I know this is crazy, buy i tried something fresh, I hope you love it.",
                  image: Image.asset("assets/images/walkthrough1.png"),
                ),
                OnboardingTemplate(
                  title: "Get bonuses on each ride",
                  subtitle:
                      "I know this is crazy, buy i tried something fresh, I hope you love it.",
                  image: Image.asset("assets/images/walkthrough2.png"),
                ),
                OnboardingTemplate(
                  title: "Invite friends and get paid.",
                  subtitle:
                      "I know this is crazy, buy i tried something fresh, I hope you love it.",
                  image: Image.asset("assets/images/walkthrough3.png"),
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OnboardingStepper(controller: _pageViewController),
                  ),
                  ClipOval(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: Icon(
                          Icons.trending_flat,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_pageViewController.page >= 2) {
                            Navigator.of(context)
                                .pushReplacementNamed(UnAuthenticatedPageRoute);
                            return;
                          }
                          _pageViewController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        padding: EdgeInsets.all(13.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
