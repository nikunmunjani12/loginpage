import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loginpage/imagespicker/imagespicker.dart';

import '2_Login_Screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DocumentReference? login;
  GoogleSignIn googleSignIn = GoogleSignIn();
  final box = GetStorage();

  @override
  void initState() {
    login = FirebaseFirestore.instance.collection('login').doc(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: login?.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data;
                    TextEditingController genderController =
                        TextEditingController(text: data!['Email']);
                    TextEditingController nameController =
                        TextEditingController(text: data['FirstName']);
                    TextEditingController usernameController =
                        TextEditingController(text: data['PhoneNo']);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Center(
                          child: Text(
                            "User Details ",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              '${data['imagesss']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Name : ${data['FirstName']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Email: ${data['Email']}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                        Center(
                          child: Text(
                            "Mob No. : ${data['PhoneNo']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      height: 300,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                                labelText: 'FirstName'),
                                          ),
                                          TextField(
                                            controller: genderController,
                                            decoration: const InputDecoration(
                                                labelText: 'Email'),
                                          ),
                                          TextField(
                                            controller: usernameController,
                                            decoration: const InputDecoration(
                                                labelText: 'PhoneNo'),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.indigo.shade900),
                                              onPressed: () {
                                                login?.update({
                                                  "FirstName":
                                                      nameController.text,
                                                  "Email":
                                                      genderController.text,
                                                  "PhoneNo":
                                                      usernameController.text
                                                });
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: const Text('Update')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Update"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo.shade900,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 70, vertical: 13)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            TextButton(
                              onPressed: () async {
                                await googleSignIn.signOut();
                                await box.erase();
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                });
                              },
                              child: Text(
                                'LOGOUT',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
