import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '2_Login_Screen.dart';
import '5_OTP.dart';

class Otpenternumber extends StatefulWidget {
  const Otpenternumber({Key? key}) : super(key: key);

  @override
  State<Otpenternumber> createState() => _OtpenternumberState();
}

class _OtpenternumberState extends State<Otpenternumber> {
  var formkey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.12,
            ),
            Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 29),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Add your phone number.We'll send you a",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
            Text(
              'verification code',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        hintText: 'Number..',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.5), width: 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.5),
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.02, horizontal: width * 0.15),
                    ),
                    onPressed: () async {
                      try {
                        auth.verifyPhoneNumber(
                          phoneNumber: '+91${number.text}',
                          verificationCompleted: (phoneAuthCredential) {
                            print('Verify');
                          },
                          verificationFailed: (error) {
                            print('Error');
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Otp5(
                                  Id: verificationId,
                                  phone: number.text,
                                  token: forceResendingToken,
                                  resendigtoken: 4,
                                ),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            print('TimeOut');
                          },
                        );
                      } on FirebaseException catch (e) {
                        print('${e.code}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${e.message}'),
                          ),
                        );
                      }
                    },
                    child: Text('Send'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkResponse(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      });
                    },
                    child: Center(
                      child: Text(
                        'Sign in with email',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
