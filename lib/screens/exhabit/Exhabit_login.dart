import 'package:currancyandgold2/screens/exhabit/Exhabit_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

import '../admin/admin_home.dart';
import 'Exhabit_Exhabitions.dart';

class ExhabitLogin extends StatefulWidget {
  static const routeName = '/ExhabitLogin';
  const ExhabitLogin({super.key});

  @override
  State<ExhabitLogin> createState() => _ExhabitLoginState();
}

class _ExhabitLoginState extends State<ExhabitLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: ListView(
              children: [
                Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    image: new DecorationImage(
                      image: new ExactAssetImage('assets/images/img.jfif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "تسجيل الدخول كمعرض",
                            style: TextStyle(
                                color: Colors.amber.shade500,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextField(
                            controller: emailController,
                            style: TextStyle(
                                fontFamily: "yel",
                                color: Colors.amber.shade500),
                            // controller: addRoomProvider.bednocon,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.amber.shade600),
                              ),

                              hintText: 'ادخل البريد الالكترونى',
                              hintStyle:
                                  TextStyle(color: Colors.amber.shade500),
                              labelText: 'البريد الالكترونى',
                              labelStyle:
                                  TextStyle(color: Colors.amber.shade500),

                              //prefixText: ' ',
                              //suffixText: 'USD',
                              //suffixStyle: const TextStyle(color: Colors.green)),
                            )),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: TextField(
                            controller: passwordController,
                            style: TextStyle(
                                fontFamily: "yel",
                                color: Colors.amber.shade500),
                            // controller: addRoomProvider.bednocon,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    BorderSide(color: Colors.amber.shade600),
                              ),

                              hintText: "ادخل كلمة المرور",
                              hintStyle:
                                  TextStyle(color: Colors.amber.shade500),
                              labelText: "كلمة المرور",
                              labelStyle:
                                  TextStyle(color: Colors.amber.shade500),

                              //prefixText: ' ',
                              //suffixText: 'USD',
                              //suffixStyle: const TextStyle(color: Colors.green)),
                            )),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Container(
                          width: 150,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.amber),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.amber.shade500)))),
                              child: Text(
                                "سجل دخول",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                var email = emailController.text.trim();
                                var password = passwordController.text.trim();

                                if (email.isEmpty || password.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please fill all fields');
                                  return;
                                }

                                if (email == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Wrong email or password');

                                  return;
                                }

                                if (password == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Wrong email or password');

                                  return;
                                }

                                ProgressDialog progressDialog = ProgressDialog(
                                    context,
                                    title: Text('Logging In'),
                                    message: Text('Please Wait'));
                                progressDialog.show();

                                try {
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  UserCredential userCredential =
                                      await auth.signInWithEmailAndPassword(
                                          email: email, password: password);

                                  if (userCredential.user != null) {
                                    progressDialog.dismiss();
                                    Navigator.pushNamed(
                                        context, ExhabitHome.routeName);
                                  }
                                } on FirebaseAuthException catch (e) {
                                  progressDialog.dismiss();
                                  if (e.code == 'user-not-found') {
                                    Fluttertoast.showToast(
                                        msg: 'User not found');
                                  } else if (e.code == 'wrong-password') {
                                    Fluttertoast.showToast(
                                        msg: 'Wrong password');
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(
                                      msg: 'Something went wrong');
                                  progressDialog.dismiss();
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
