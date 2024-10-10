// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class Searchbar extends StatefulWidget {
//   final String text;
//   final GestureTapCallback? press;
//   const Searchbar(
//       {super.key,
//       required this.text,
//       this.press,
//       required void Function(String query) onChanged,
//       required TextEditingController searchcontroller});

//   @override
//   State<Searchbar> createState() => _SearchbarState();
// }

// class _SearchbarState extends State<Searchbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 1,
//             )
//           ]),
//       child: Row(children: [
//         IconButton(
//             icon: FaIcon(
//               FontAwesomeIcons.sliders,
//               size: 22,
//               color: Color.fromARGB(255, 87, 124, 163),
//             ),
//             onPressed: () {
//               widget.press;
//             }),
//         Expanded(
//             child: TextField(
//           textInputAction: TextInputAction.search,
//           textAlignVertical: TextAlignVertical.center,
//           textAlign: TextAlign.right,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             hintText: widget.text,
//           ),
//         )),
//         IconButton(
//             icon: Icon(
//               Icons.search,
//             ),
//             onPressed: () {}),
//       ]),
//     );
//   }
// }
