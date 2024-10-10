import 'package:flutter/material.dart';
import 'package:rafahia_web/uitles/colors.dart';

import '../Login/login_screen.dart';
import '../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const LoginScreenn();
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Signup();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: LigthColor.maingreencolor,
            elevation: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: Text(
              "إنشاء حساب ",
              style:
                  const TextStyle(color: LigthColor.whiteColor, fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }
}
