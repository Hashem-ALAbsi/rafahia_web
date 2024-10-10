import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rafahia_web/uitles/colors.dart';

class Searchbar extends StatefulWidget {
  final String text;
  final Function(String) onChanged;
  final GestureTapCallback? press;
  final GestureTapCallback? presss;

  final TextEditingController searchcontroller;
  const Searchbar({
    super.key,
    required this.text,
    this.press,
    this.presss,
    required this.searchcontroller,
    required this.onChanged,
  });

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 60,
      decoration: BoxDecoration(
          color: LigthColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: LigthColor.shadow.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            )
          ]),
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.x,
                size: 20,
                color: LigthColor.iconnormal.withOpacity(0.1),
              ),
              onPressed: () {
                widget.presss;
              }),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextField(
            style: TextStyle(
                color: LigthColor.maingreencolor,
                fontFamily: "Rubik",
                fontSize: 15),
            controller: widget.searchcontroller,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.right,
            cursorColor: LigthColor.roundbage,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.text,
                hintStyle: TextStyle(fontSize: 16, fontFamily: "Rubik")),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.search,
            color: LigthColor.roundbage,
            size: 25,
          ),
        ),
      ]),
    );
  }
}
