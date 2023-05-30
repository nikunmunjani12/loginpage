import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '2_Login_Screen.dart';
import '6-App_Open_Screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formkey = GlobalKey<FormState>();
  CollectionReference Users = FirebaseFirestore.instance.collection('login');
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final box = GetStorage();
  bool loading = false;
  bool hidepassword = false;
  int selec = 0;
  File? image;
  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference imageupload =
      FirebaseFirestore.instance.collection('login');
  String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1f5fe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Create New\naccount',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                XFile? file = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 10);

                                image = File(file!.path);
                                setState(() {});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: const BoxDecoration(
                                    color: Colors.cyan,
                                    shape: BoxShape.circle,
                                  ),
                                  child: image == null
                                      ? const Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 35,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 90,
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () async {
                                    XFile? file = await picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 10);

                                    image = File(file!.path);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 162,
                        child: TextFormField(
                          controller: firstname,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "First Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Place Enter First Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 60,
                        width: 162,
                        child: TextFormField(
                          controller: lastname,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_add_alt,
                            ),
                            hintText: "Last Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Place Enter Last Name';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: email,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: hidepassword,
                    controller: password,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidepassword = !hidepassword;
                          });
                        },
                        icon: hidepassword == true
                            ? const Icon(
                                Icons.visibility_off,
                              )
                            : const Icon(
                                Icons.visibility,
                              ),
                      ),
                      labelText: "Password",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Password';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneno,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android_sharp,
                      ),
                      labelText: "Phone No",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place Enter Phone No';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Gender : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Male',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                      Radio(
                          value: 1,
                          groupValue: selec,
                          onChanged: (int? value) {
                            setState(() {
                              selec = value!;
                            });
                          }),
                      const Text(
                        'Female',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19),
                      ),
                      Radio(
                          value: 2,
                          groupValue: selec,
                          onChanged: (int? value) {
                            setState(() {
                              selec = value!;
                            });
                          })
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  loading
                      ? const CircularProgressIndicator()
                      : Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 60),
                                backgroundColor: Colors.blue.shade900),
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              try {
                                UserCredential credential =
                                    await auth.createUserWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text);
                                box.write('userId', credential.user!.uid);
                                setState(() {
                                  loading = false;
                                });
                                print('${credential.user!.email}');
                                print(credential.user!.uid);

                                await storage
                                    .ref('profile/user1ProfileImage.png')
                                    .putFile(image!)
                                    .then(
                                  (p0) async {
                                    url = await p0.ref.getDownloadURL();

                                    print('URL $url');
                                  },
                                );

                                Users.doc(credential.user!.uid).set({
                                  "FirstName": firstname.text,
                                  "LastName": lastname.text,
                                  "Email": email.text,
                                  "Password": password.text,
                                  "PhoneNo": phoneno.text,
                                  "imagesss": url,
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      userId: credential.user!.uid,
                                    ),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                print('${e.code}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${e.message}"),
                                    action: SnackBarAction(
                                      label: 'undo',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                                if (formkey.currentState!.validate()) {}
                              }
                            },
                            child: const Text("Register Now"),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account ?"),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          });
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
