import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rafahia_web/uitles/colors.dart';

//مقترح والاعلى تقييما
class TextHomeMore extends StatefulWidget {
  const TextHomeMore({
    super.key,
    this.left_botton_text = "",
    this.righe_text = "",
    required this.press,
  });

  final String righe_text;
  final String left_botton_text;
  final VoidCallback? press;

  @override
  State<TextHomeMore> createState() => _TextHomeMoreState();
}

class _TextHomeMoreState extends State<TextHomeMore> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: widget.press,
          style: TextButton.styleFrom(
            foregroundColor: LigthColor.more,
          ),
          child: Text(
            textScaleFactor: ScaleSize.textScaleFactor(context),
            widget.left_botton_text,
            style: TextStyle(fontFamily: "Rubik", fontSize: 12),
          ),
        ),
        Text(
          textScaleFactor: ScaleSize.textScaleFactor(context),
          widget.righe_text,
          style: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: LigthColor.massegeColor),
        ),
      ],
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
