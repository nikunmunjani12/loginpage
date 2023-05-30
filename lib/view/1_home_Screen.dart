import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loginpage/Constrant/comon_button.dart';

import '2_Login_Screen.dart';

class Sleshscreen1 extends StatefulWidget {
  const Sleshscreen1({Key? key}) : super(key: key);

  @override
  State<Sleshscreen1> createState() => _Sleshscreen1State();
}

class _Sleshscreen1State extends State<Sleshscreen1> {
  final box = GetStorage();
  @override
  void initState() {
    Timer timer = Timer(
      const Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                    Image.asset('assets/images/jungle.jpg', fit: BoxFit.cover),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: height * 0.75),
                        child: commonbutton('Get started', () {
                          setState(() {});
                        }, height * 0.065, width * 0.50, Colors.blueGrey)),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'Already have an account',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
