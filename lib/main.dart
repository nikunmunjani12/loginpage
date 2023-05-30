import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginpage/tackall/1_products.dart';
import 'package:loginpage/view/1_home_Screen.dart';
import 'package:loginpage/view/2_Login_Screen.dart';
import 'package:loginpage/view/3_RegisterScreen.dart';
import 'package:loginpage/view/4_Otp_Number_Enter.dart';
import 'package:loginpage/view/6-App_Open_Screen.dart';

import 'ChatScreen/1_ChatApp.dart';
import 'imagespicker/imagespicker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sleshscreen1(),
    );
  }
}
