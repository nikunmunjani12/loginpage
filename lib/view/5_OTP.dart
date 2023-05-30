import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '4_Otp_Number_Enter.dart';

class Otp5 extends StatefulWidget {
  const Otp5(
      {Key? key, this.Id, this.token, this.phone, required this.resendigtoken})
      : super(key: key);
  final Id;
  final token;
  final phone;
  final int resendigtoken;
  @override
  State<Otp5> createState() => _Otp5State();
}

class _Otp5State extends State<Otp5> {
  TextEditingController Otp = TextEditingController();
  String? otpcode;
  FirebaseAuth auth = FirebaseAuth.instance;
  int second = 60;
  bool isResend = false;
  void Timerdemo1() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
      second--;
      if (second == 0) {
        timer.cancel();
        second = 60;
        setState(() {});
        isResend = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Timerdemo1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.02, left: width * 0.04),
              child: InkResponse(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Otpenternumber(),
                      ),
                    );
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Center(
              child: Text(
                'Varification',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: Text(
                'Enter tha send to tha number',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Text(
                '${widget.phone}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Pinput(
                length: 6,
                controller: Otp,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    otpcode = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.5),
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.15),
                ),
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.Id, smsCode: Otp.text);
                    UserCredential userCredential =
                        await auth.signInWithCredential(credential);
                    print('${userCredential.user!.phoneNumber}');
                    print('${userCredential.user!.uid}');
                  } on FirebaseException catch (e) {
                    print('${e.code}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e.message}'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Verify',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Center(
                child: Text(
              '${second}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
            )),
            SizedBox(
              height: height * 0.03,
            ),
            isResend
                ? Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(0.5),
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.02, horizontal: width * 0.15),
                      ),
                      onPressed: () async {
                        await auth.verifyPhoneNumber(
                          phoneNumber: '91${widget.phone}',
                          verificationCompleted: (phoneAuthCredential) {
                            print('verifyed');
                          },
                          verificationFailed: (error) {
                            print('ERROR');
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Otp5(
                                  Id: verificationId,
                                  phone: Otp.text,
                                  token: forceResendingToken,
                                  resendigtoken: 4,
                                ),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            print('Time out');
                          },
                          forceResendingToken: widget.token,
                        );
                        setState(() {});
                        isResend = false;
                        Timerdemo1();
                      },
                      child: Text("Resend OTP"),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
