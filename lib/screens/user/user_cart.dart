import 'package:currancyandgold2/screens/user/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';
import 'User_Exhabitions.dart';

class UserCart extends StatefulWidget {
  static const routeName = '/ UserCart';
  String Exhabit;
  UserCart({super.key, required this.Exhabit});

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Align(
                  alignment: Alignment.center,
                  child:
                      Text("ادخال طلب", style: TextStyle(color: Colors.black))),
              backgroundColor: Colors.amber.shade500,
              actions: [],
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(),
                      image: new DecorationImage(
                        image: new ExactAssetImage('assets/images/img.jfif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "اهلا بك ",
                    style: TextStyle(
                        fontSize: 25, fontFamily: "yel", color: Colors.black),
                  )),
                  Container(
                    height: 20,
                  ),
                  TextField(
                      controller: nameController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "الاسم",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: numberController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "كم قطعه",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: addressController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "العنوان",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: phoneController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "رقم التلفون",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  Container(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: () async {
                      String name = nameController.text.trim();
                      String number = numberController.text.trim();
                      String address = addressController.text.trim();
                      String phone = phoneController.text.trim();

                      if (name.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter name');
                        return;
                      }
                      if (phone.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter phone');
                        return;
                      }
                      if (number.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter count ');
                        return;
                      }
                      if (address.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter address');
                        return;
                      }

                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        DatabaseReference userRef = FirebaseDatabase.instance
                            .reference()
                            .child('Carts')
                            .child("${widget.Exhabit}");
                        String? id = userRef.push().key;

                        String uid = user!.uid;
                        int dt = DateTime.now().millisecondsSinceEpoch;

                        await userRef.child(id!).set({
                          'name': name,
                          'address': address,
                          'uid': uid,
                          'number ': number,
                          'id': id,
                          'phone': phone,
                        });
                        showAlertDialog(context);
                      } else {
                        Fluttertoast.showToast(msg: 'Failed');
                      }
                    },
                    child: Text('ارسال',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            )));
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.amber.shade500,
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, CustomerHomePage.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("لقد تم الشراء بنجاح"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
