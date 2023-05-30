import 'package:flutter/material.dart';

TextFormField comonFormfield(
  String title,
  Controller,
  Function() validator,
) {
  return TextFormField(
    controller: Controller,
    decoration: InputDecoration(
      hintText: title,8
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    //validator: validator,
  );
}

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TextFormFieldDemo extends StatefulWidget {
//   const TextFormFieldDemo({Key? key}) : super(key: key);
//
//   @override
//   State<TextFormFieldDemo> createState() => _TextFormFieldDemoState();
// }
//
// class _TextFormFieldDemoState extends State<TextFormFieldDemo> {
//   TextEditingController AA = TextEditingController();
//   TextEditingController BB = TextEditingController();
//   var one = GlobalKey<FormState>();
//   var username = "Nikunj@gmail.com";
//   var pass = "Abc@12345";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: one,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: AA,
//               decoration: InputDecoration(hintText: "email"),
//               validator: (value) {
//                 setState(() {});
//                 bool emailvalid = RegExp(
//                     "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$")
//                     .hasMatch(value!);
//                 if (emailvalid) {
//                   return null;
//                 } else {
//                   return "envalid email";
//                 }
//               },
//             ),
//             TextFormField(
//               controller: BB,
//               decoration: InputDecoration(hintText: "Password"),
//               validator: (value) {
//                 setState(() {});
//                 bool password = RegExp(
//                     "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$")
//                     .hasMatch(value!);
//                 if (password) {
//                   return null;
//                 } else {
//                   return "envalid password";
//                 }
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   if (one.currentState!.validate()) {
//                     if (username == AA.text && pass == BB.text) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Text("nikunj bhai"),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("nikunj bro invalid")),
//                       );
//                     }
//                   }
//                 });
//               },
//               child: Text("enter"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
