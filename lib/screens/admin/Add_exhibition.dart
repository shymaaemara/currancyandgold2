import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


import 'add_company.dart';
class AddExhibition extends StatefulWidget {
  static const routeName = '/AddExhibition';
  const AddExhibition({super.key});

  @override
  State<AddExhibition> createState() => _AddExhibitionState();
}

class _AddExhibitionState extends State<AddExhibition> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var placeController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String imageUrl = '';
  File? image;

  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  Future pickImageFromCamera() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
        Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            title: Text('اضافة معارض',
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.amber.shade500,
          ),
          body:Container(
            color: Colors.black,
            child: Padding(padding:   EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 20),child:
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(

                  children: [

                  Text('صورة المعرض',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.yellow)),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor:
                              Color.fromARGB(255, 235, 234, 234),
                              backgroundImage:
                              image == null ? null : FileImage(image!),
                            )),
                        Positioned(
                            top: 120,
                            left: 120,
                            child: SizedBox(
                              width: 50,
                              child: RawMaterialButton(
                                // constraints: BoxConstraints.tight(const Size(45, 45)),
                                  elevation: 10,
                                  fillColor: Colors.deepOrangeAccent,
                                  child: const Align(
                                    // ignore: unnecessary_const
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 22)),
                                  padding: const EdgeInsets.all(15),
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Choose option',
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.red)),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        pickImageFromDevice();
                                                      },

                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                          Text('Gallery',
                                                              style:
                                                              TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        pickImageFromCamera();
                                                      },

                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                                Icons.camera,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                          Text('Camera',
                                                              style:
                                                              TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },

                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                          Text('Remove',
                                                              style:
                                                              TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ))
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
                        hintText: "اسم المعرض",
                        hintStyle: TextStyle(color: Colors.amber.shade500),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(height: 20,),
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
                        hintStyle: TextStyle(color: Colors.amber.shade500),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(height: 20,),
                  TextField(
                      controller: placeController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "المكان",
                        hintStyle: TextStyle(color: Colors.amber.shade500),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(height: 20,),
                  TextField(
                      controller: emailController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "الايميل",
                        hintStyle: TextStyle(color: Colors.amber.shade500),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(height: 20,),
                  TextField(
                      controller: passwordController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "الباسورد",
                        hintStyle: TextStyle(color: Colors.amber.shade500),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                      onPressed: () async {
                        String name = nameController.text.trim();
                        String place = placeController.text.trim();
                        String phone = phoneController.text.trim();
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        if (name.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter name');
                          return;
                        }

                        if (place.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter name');
                          return;
                        }
                        if (phone.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter phone');
                          return;
                        }
                        if (email.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter email');
                          return;
                        }
                        if (password.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter password');
                          return;
                        }
                    try {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                    );

                    User? user = userCredential.user;


                    if (userCredential.user != null) {
                    DatabaseReference userRef = FirebaseDatabase
                        .instance
                        .reference()
                        .child('exhibittions');
                    String? id = userRef.push().key;
                    String? role = 'معرض';
                    String? uid = userCredential.user!.uid;
                    int? dt = DateTime.now().millisecondsSinceEpoch;
                    user!.updateProfile(displayName: role);
                    await userRef.child(id!).set({
                    'name': name,
                    'email': email,

                    'password': password,
                    'place': place,
                    'uid': uid,
                    'phone': phone,
                    'id': id,
                    'imageUrl': imageUrl,

                    });
                    DatabaseReference exhibitRef = FirebaseDatabase
                        .instance
                        .reference()
                        .child('Users');

                    await exhibitRef .child(uid).set({
                      'fullName': name,
                      'email': email,
                      'password': password,
                      'uid': uid,
                      'dt': dt,

                    });

                    FirebaseAuth.instance.signOut();
                    Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null;
                    } else {
                      Fluttertoast.showToast(msg: 'Failed');

                    }

                    } on FirebaseAuthException catch (e) {

                      if (e.code == 'email-already-in-use') {
                        Fluttertoast.showToast(msg: 'Email is already exist');

                      } else if (e.code == 'weak-password') {
                        Fluttertoast.showToast(msg: 'Password is weak');

                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: 'Something went wrong');

                    }
                      },
                    child: Text('حفظ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),)
                ],),
              )
              ,),),

        )  );
  }
}
