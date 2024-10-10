import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafahia_web/uitles/colors.dart';

//--------------------------
// انميشن للتنقل من الواجةة الرئيسية الى الفنادق والشاليهات والاستراحات
class FadeRoute1 extends PageRouteBuilder {
  final Widget page;

  FadeRoute1(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
}

class AnimatingBg1 extends StatefulWidget {
  final Widget child;

  AnimatingBg1({required this.child});
  @override
  _AnimatingBg1State createState() => _AnimatingBg1State();
}

class _AnimatingBg1State extends State<AnimatingBg1>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    LigthColor.anm1,
    LigthColor.anm2,
    LigthColor.anm3,
    LigthColor.anm4,
    LigthColor.anm5,
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = LigthColor.anm6;
  Color topColor = LigthColor.anm7;
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = LigthColor.anm8;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
      child: widget.child,
    );
  }
}

// for wallet
class AnimatingBg2 extends StatefulWidget {
  final Widget child;

  AnimatingBg2({required this.child});
  @override
  _AnimatingBg2State createState() => _AnimatingBg2State();
}

class _AnimatingBg2State extends State<AnimatingBg2>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    LigthColor.nanm1,
    LigthColor.nanm2,
    LigthColor.nanm3,
    LigthColor.nanm4,
    LigthColor.nanm5,
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = LigthColor.nanm6;
  Color topColor = LigthColor.nanm7;
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = LigthColor.nanm8;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
      child: widget.child,
    );
  }
}

class AnimatingBg3 extends StatefulWidget {
  final Widget child;

  AnimatingBg3({required this.child});
  @override
  _AnimatingBg3State createState() => _AnimatingBg3State();
}

class _AnimatingBg3State extends State<AnimatingBg3>
    with TickerProviderStateMixin {
  List<Color> colorList = [
    LigthColor.nanm1n,
    LigthColor.nanm2n,
    LigthColor.nanm3n,
    LigthColor.nanm4n,
    LigthColor.nanm5n,
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = LigthColor.nanm6;
  Color topColor = LigthColor.nanm7;
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = LigthColor.nanm8;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      onEnd: () {
        setState(
          () {
            index = index + 1;
            bottomColor = colorList[index % colorList.length];
            topColor = colorList[(index + 1) % colorList.length];
          },
        );
      },
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [bottomColor, topColor],
        ),
      ),
      child: widget.child,
    );
  }
}
