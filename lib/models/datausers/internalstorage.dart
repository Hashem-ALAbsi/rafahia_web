// file_operations.dart
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileOperations {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get localFile async {
    final path = await localPath;
    return File('$path/dart.txt');
  }

  static Future<File> writeFile(String data) async {
    final file = await localFile;
    return file.writeAsString(data);
  }

  static Future<int> readFile() async {
    try {
      final file = await localFile;
      String contents = await file.readAsString();
      var idclient = int.parse(contents);
      return idclient;
    } catch (e) {
      return 0;
      //return "Failed to read the file";
    }
  }
}







// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // ... rest of your app
//     );
//   }
// }

// // Usage example:
// // await FileOperations.writeFile('Your data here');
// // String data = await FileOperations.readFile();










// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// Future<String> apppath() async{
//   final path=await getApplicationDocumentsDirectory();
//   return path.path;
// }
// Future<File> appfile() async{
//   final file=await apppath();
//   return  File('$file/dart.txt');
// }
// Future<File> writeFile(String data) async{
//   final file=await(appfile());
//   return file.writeAsString('$data');
// }
// Future<String> ReadFile() async{
//   try{
//     final file=await (appfile());
//     String data=await (file.readAsString());
//     return data;
//   }
//   catch(e){
//     return "there is N file";
//   }
// }
// final TextEditingController input= TextEditingController();
// final TextEditingController output= TextEditingController();
// void main() async{
//   runApp( MaterialApp(
//     home:  Scaffold(
//       appBar: AppBar(title:  Text('files'),centerTitle: true,),
//       body:  Center(
//         child: Column(
//           children: [
//             TextField(controller: input),
//             TextField(controller: output),
//             ElevatedButton(
//               child: Text("save"), onPressed: (){
//               writeFile(input.text);
//             },),
//             ElevatedButton(
//               onPressed: () async{
//                 output.text=await ReadFile();
//               },
//               child: Text("load"),)
//           ],
//         ),
//       ),
//     ),
//   ));
// }