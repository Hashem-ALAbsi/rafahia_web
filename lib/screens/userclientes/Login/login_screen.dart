import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../api/helper/api_massegefirebase.dart';
import '../../../uitles/colors.dart';
import '../../../widget/responsive.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreenn extends StatefulWidget {
  const LoginScreenn({super.key});

  @override
  State<LoginScreenn> createState() => _LoginScreennState();
}

class _LoginScreennState extends State<LoginScreenn> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future<void> _gettoken() async {
    String? token = await TestMasseging.getTokenFB();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gettoken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LigthColor.backscreen,
      body: // didDispose == false
          //     ? Center(
          //         child: LottieBuilder.asset(
          //           'assets/animation/loading_butifol.json',
          // height: 180,
          // width: 180,

          // :

          Stack(
        children: [
          Image(
              image: AssetImage('assets/images/blutt.png'),
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SingleChildScrollView(
                child: Center(
              child: Responsive(
                mobile: MobileLoginScreen(),
                desktop: Row(
                  children: [
                    const SizedBox(height: defaultPadding * 2),
                    Expanded(
                      child: Column(
                        children: [
                          Text("تسجيل الدخول",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                color: LigthColor.caleder,
                                fontFamily: "Rubik",
                              )),
                          const SizedBox(height: defaultPadding * 2),
                          LottieBuilder.asset(
                            'assets/animation/login.json',
                            height: 400,
                            width: 400,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 450,
                            child: FormLogin(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ]),
        ],
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: 30,
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
              'assets/animation/login.json',
              height: 240,
              width: 240,
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: FormLogin(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
