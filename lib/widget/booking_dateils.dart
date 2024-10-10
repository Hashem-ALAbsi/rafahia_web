import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../uitles/colors.dart';

class Circalcolor extends StatefulWidget {
  final double? top;
  final double? rigth;
  final Color? maincolor;

  const Circalcolor({super.key, this.top, this.rigth, this.maincolor});

  @override
  State<Circalcolor> createState() => _CircalcolorState();
}

class _CircalcolorState extends State<Circalcolor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.top ?? 0, left: widget.rigth ?? 0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: widget.maincolor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: LigthColor.shadow,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 0.0),
                ),
              ],
            )),
      ),
    );
  }
}

class TextDateils extends StatefulWidget {
  final String? textapi;
  final String? text;

  const TextDateils({
    super.key,
    this.textapi,
    this.text,
  });

  @override
  State<TextDateils> createState() => _TextDateilsState();
}

class _TextDateilsState extends State<TextDateils> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textScaleFactor: ScaleSize.textScaleFactor(context),
            widget.textapi ?? "",
            textDirection: TextDirection.rtl,
            // textAlign: TextAlign.right,
            style: TextStyle(fontFamily: "Rubik", fontSize: 13),
          ),
          Text(
              textScaleFactor: ScaleSize.textScaleFactor(context),
              widget.text ?? "",
              textDirection: TextDirection.rtl,
              // textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "Rubik", fontSize: 13)),
        ],
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1800) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
