import 'package:flutter/material.dart';

import '../uitles/colors.dart';

class InputFild extends StatelessWidget {
  const InputFild(
      {super.key,
      this.icon,
      required this.hint,
      required this.controller,
      required this.texttype,
      required this.validator});

  final IconData? icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType texttype;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextFormField(
        validator: validator,
        keyboardType: texttype,
        controller: controller,
        textAlign: TextAlign.end,
        style: const TextStyle(
            color: LigthColor.caleder,
            fontFamily: "Rubik",
            fontWeight: FontWeight.w500),
        cursorColor: Color.fromARGB(255, 15, 74, 126),
        decoration: InputDecoration(
            suffixIcon: Icon(
              icon,
              color: Color.fromARGB(255, 59, 89, 114),
            ),
            hintText: hint,
            border: InputBorder.none),
      ),
    );
  }
}

class InputFildpepolenum extends StatelessWidget {
  const InputFildpepolenum(
      {super.key,
      this.icon,
      required this.hint,
      required this.controller,
      required this.texttype,
      required this.validator});

  final IconData? icon;
  final String hint;
  final TextEditingController controller;
  final TextInputType texttype;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return
        // InputContainer(
        //   child:
        TextFormField(
      validator: validator,
      keyboardType: texttype,
      controller: controller,
      textAlign: TextAlign.end,
      style: const TextStyle(
          color: Colors.white,
          // LigthColor.caleder,
          fontFamily: "Rubik",
          // fontSize: 10,
          fontWeight: FontWeight.normal),
      cursorColor: Colors.white,
      //Color.fromARGB(255, 15, 74, 126),
      decoration: InputDecoration(
          suffixIcon: Icon(
            icon, color: Colors.white,
            //Color.fromARGB(255, 59, 89, 114),
            // Colors.white
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none),
      // ),
    );
  }
}

class Inputname extends StatelessWidget {
  const Inputname(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.texttype})
      : super(key: key);

  final String hint;

  final TextEditingController controller;
  final TextInputType texttype;
  @override
  Widget build(BuildContext context) {
    return InputContainerName(
      child: TextFormField(
        keyboardType: texttype,
        controller: controller,
        validator: (input) {
          if (controller.text.isEmpty) {
            return " enter";
          } else {
            return null;
          }
        },
        textAlign: TextAlign.end,
        cursorColor: Color.fromARGB(255, 200, 219, 236),
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
      ),
    );
  }
}

class InputContainerName extends StatelessWidget {
  const InputContainerName({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 200, 219, 236)),
    );
  }
}

// class InputFildPassword extends StatelessWidget {
//   const InputFildPassword(
//       {Key? key,
//       required this.icon,
//       required this.hint,
//       required this.controller})
//       : super(key: key);

//   final IconData icon;
//   final String hint;
//   final TextEditingController controller;
//   @override
//   Widget build(BuildContext context) {
//     return InputContainer(
//       child: TextField(
//         keyboardType: TextInputType.visiblePassword,
//         controller: controller,
//         obscureText: true,
//         textAlign: TextAlign.end,
//         cursorColor: Color.fromARGB(255, 200, 219, 236),
//         decoration: InputDecoration(
//             suffixIcon: Icon(
//               icon,
//               color: Color.fromARGB(255, 59, 89, 114),
//             ),
//             hintText: hint,
//             border: InputBorder.none),
//       ),
//     );
//   }
// }

class Inputpass extends StatefulWidget {
  const Inputpass({super.key, this.icon, this.hint, this.controller});
  final IconData? icon;
  final String? hint;
  final TextEditingController? controller;
  @override
  State<Inputpass> createState() => _InputpassState();
}

class _InputpassState extends State<Inputpass> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        controller: widget.controller,
        textAlign: TextAlign.end,
        obscureText: passwordVisible,
        style: const TextStyle(
            color: LigthColor.caleder,
            fontFamily: "Rubik",
            fontWeight: FontWeight.w500),
        cursorColor: Color.fromARGB(255, 15, 74, 126),
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          suffixIcon: Icon(
            widget.icon,
            color: Color.fromARGB(255, 59, 89, 114),
          ),
          prefixIcon: IconButton(
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(
                () {
                  passwordVisible = !passwordVisible;
                },
              );
            },
          ),
          alignLabelWithHint: false,
        ),
      ),
    );
  }
}

class InputContainer extends StatelessWidget {
  const InputContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 200, 219, 236)),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.titel,
  }) : super(key: key);
  final String titel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 59, 89, 114),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Text(
          titel,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class InputEdit extends StatelessWidget {
  const InputEdit(
      {super.key,
      required this.readonly,
      this.enabled,
      required this.hint,
      required this.controller,
      required this.texttype,
      required this.validator});
  final bool readonly;
  final bool? enabled;
  final String hint;
  final TextEditingController controller;
  final TextInputType texttype;
  final String? Function(String?)? validator;
  //final String? Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readonly,
      validator: validator,
      //onChanged:(value) => value,
      keyboardType: texttype,
      controller: controller,
      textAlign: TextAlign.right,
      cursorColor: Color.fromARGB(255, 200, 219, 236),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          labelText: hint,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 87, 124, 163),
            fontFamily: "Rubik",
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 87, 124, 163),
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(255, 87, 124, 163),
          ))),
    );
  }
}

class PassEditt extends StatefulWidget {
  const PassEditt({super.key, this.icon, this.hint, this.controller});
  final IconData? icon;
  final String? hint;
  final TextEditingController? controller;
  @override
  State<PassEditt> createState() => _PassEdittState();
}

class _PassEdittState extends State<PassEditt> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      controller: widget.controller,
      cursorColor: Color.fromARGB(255, 200, 219, 236),
      textAlign: TextAlign.right,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        labelText: widget.hint,
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 87, 124, 163),
          fontFamily: "Rubik",
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(255, 87, 124, 163),
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(255, 87, 124, 163),
        )),
        suffixIcon: Icon(
          widget.icon,
          color: Color.fromARGB(255, 59, 89, 114),
        ),
        prefixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        alignLabelWithHint: false,
      ),
    );
  }
}
