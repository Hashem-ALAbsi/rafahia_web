import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../uitles/colors.dart';
import '../../../widget/responsive.dart';
import 'components/signup_form.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LigthColor.backscreen,
      body: 
      // didDispose == false
      //         ? Center(
      //             child: LottieBuilder.asset(
      //               'assets/animation/loading_butifol.json',
      //     height: 180,
      //     width: 180,),)

      //     :
           SingleChildScrollView(
        child: Stack(
          children: [
            Image(
                image: AssetImage('assets/images/blutt.png'),
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: Responsive(
                  mobile: MobileSignupScreen(),
                  desktop: Row(
                    children: [
                      const SizedBox(height: defaultPadding * 2),
                      Expanded(
                        child: Column(
                          children: [
                            Text(" إنشاء حساب",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  color: LigthColor.caleder,
                                  fontFamily: "Rubik",
                                )),
                            const SizedBox(height: defaultPadding * 2),
                            LottieBuilder.asset(
                              'assets/animation/signin.json',
                              height: 400,
                              width: 400,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 130),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 450,
                                child: Signupform(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ]),
          ],
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Text("تسجيل الدخول",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27,
              color: LigthColor.caleder,
              fontFamily: "Rubik",
            )),
        const SizedBox(height: defaultPadding * 2),
        LottieBuilder.asset(
          'assets/animation/signin.json',
          height: 250,
          width: 250,
        ),

        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: Signupform(),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    );
  }
}
