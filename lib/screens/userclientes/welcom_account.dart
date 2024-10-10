import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../uitles/colors.dart';
import '../../widget/responsive.dart';
import 'components/login_signup_btn.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Responsive(
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 2),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: LottieBuilder.asset(
                              'assets/animation/welco.json',
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: defaultPadding * 2),
                    ],
                  )),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: LoginAndSignupBtn(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              mobile: MobileWelcomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: LottieBuilder.asset(
                    'assets/animation/welco.json',
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
