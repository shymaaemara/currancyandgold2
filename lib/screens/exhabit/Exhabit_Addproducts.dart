import 'dart:io';

import 'package:currancyandgold2/screens/exhabit/Exhabit_home.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';
import 'Exhabit_Exhabitions.dart';

class ExhabitAddproducts extends StatefulWidget {
  final String Exhabit;
  static const routeName = '/ExhabitAddproducts';
  const ExhabitAddproducts({super.key, required this.Exhabit});

  @override
  State<ExhabitAddproducts> createState() => _ExhabitAddproductsState();
}

class _ExhabitAddproductsState extends State<ExhabitAddproducts> {
  var nameController = TextEditingController();

  var caliberController = TextEditingController();
  var gramController = TextEditingController();

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

  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber.shade500,
            actions: [],
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text('صورة المنتج',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
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
                                  fillColor: Colors.amber.shade500,
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
                                                    fontWeight: FontWeight.w600,
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
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          Text('Gallery',
                                                              style: TextStyle(
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
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          Text('Camera',
                                                              style: TextStyle(
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
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          Text('Remove',
                                                              style: TextStyle(
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
                        hintText: "اسم المنتج",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: caliberController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "كم عيار",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: gramController,
                      style: TextStyle(
                          fontFamily: "yel", color: Colors.amber.shade500),
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.amber.shade600),
                        ),
                        hintText: "كم جرام",
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.amber.shade500),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                    ),
                    onPressed: () async {
                      String name = nameController.text.trim();
                      int gram = int.parse(gramController.text);
                      int caliber = int.parse(caliberController.text);

                      if (name.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter name');
                        return;
                      }

                      if (gram == null) {
                        Fluttertoast.showToast(msg: 'Please enter name');
                        return;
                      }
                      if (caliber == null) {
                        Fluttertoast.showToast(msg: 'Please enter phone');
                        return;
                      }

                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        DatabaseReference userRef = FirebaseDatabase.instance
                            .reference()
                            .child('product')
                            .child('${widget.Exhabit}');
                        String? id = userRef.push().key;

                        String uid = user!.uid;
                        int dt = DateTime.now().millisecondsSinceEpoch;

                        await userRef.child(id!).set({
                          'name': name,
                          'caliber': caliber,
                          'uid': uid,
                          'gram': gram,
                          'id': id,
                          'imageUrl': imageUrl,
                        });
                        showAlertDialog(context);
                      } else {
                        Fluttertoast.showToast(msg: 'Failed');
                      }
                    },
                    child: Text('اضافه',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.amber.shade500,
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, ExhabitHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("your currency product is created"),
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
