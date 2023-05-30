import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../ChatScreen/2_ChatScreen.dart';
import '3_RegisterScreen.dart';
import '6-App_Open_Screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth1 = FirebaseAuth.instance;
  bool loading = false;
  bool hidepassword = false;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  "Set a name for your profile\nthe password",
                  style: TextStyle(color: Colors.black38, fontSize: 14),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.mail_outline,
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
                      return 'Place Enter User Name';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: hidepassword,
                  controller: password,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                  height: 40,
                ),
                loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            UserCredential credential =
                                await auth.signInWithEmailAndPassword(
                                    email: email.text, password: password.text);

                            print('EMAIL${credential.user!.email}');
                            print('UID${credential.user!.uid}');
                            await box.write('userId', credential.user!.uid);
                            setState(() {
                              loading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatTask(uid: credential.user!.uid),
                                ));
                          } on FirebaseAuthException catch (e) {
                            print('${e.code}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${e.message}"),
                              ),
                            );
                            setState(() {
                              loading = false;
                            });
                            if (formkey.currentState!.validate()) {}
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 15),
                            backgroundColor: Colors.blue.shade900),
                        child: const Text("Login"),
                      ),
                const SizedBox(
                  height: 25,
                ),
                Text("-OR-"),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Sign in with",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Center(
                  child: InkResponse(
                    onTap: () async {
                      GoogleSignInAccount? account =
                          await googleSignIn.signIn();
                      GoogleSignInAuthentication authentication =
                          await account!.authentication;
                      OAuthCredential credential =
                          GoogleAuthProvider.credential(
                        idToken: authentication.idToken,
                        accessToken: authentication.accessToken,
                      );
                      UserCredential usercredential =
                          await auth1.signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(userId: 'ZgNJZbWqgogiLRIpJMnogxeeh3K3'),
                        ),
                      );
                      print(usercredential.user!.email);
                      print(usercredential.user!.uid);
                      //  print(usercredential.user!.photoURL);
                    },
                    child: Image.asset("assets/images/google.png", scale: 14),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
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
    );
  }
}
