import 'package:currancyandgold2/screens/exhabit/Exhabit_Exhabitions.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/exhibit_model.dart';
import '../../models/user_model.dart';
import '../user/openscreen.dart';
import 'Exhabit_Carts.dart';

class ExhabitHome extends StatefulWidget {
  static const routeName = '/ExhabitHome';
  const ExhabitHome({super.key});

  @override
  State<ExhabitHome> createState() => _ExhabitHomeState();
}

class _ExhabitHomeState extends State<ExhabitHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  void initState() {
    getUserData();
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
  }

  late Users currentUser;
  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("Users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print('${currentUser}');
    });
  }

  List<Exhibit> ExhibitList = [];
  List<String> keyslist = [];

  @override
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
              title: Align(
                  alignment: Alignment.center,
                  child: Text("الصفحة الرئيسية",
                      style: TextStyle(color: Colors.black))),
              backgroundColor: Colors.amber.shade500,
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmation!'),
                              content: Text('Are you sure to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushNamed(
                                        context, OpenScreen.routeName);
                                  },
                                  child: Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('No'),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.exit_to_app))
              ],
              iconTheme: IconThemeData(color: Colors.black)),
          body: Container(
            color: Colors.black,
            child: ListView(
              children: [
                Image(
                  image: AssetImage('assets/images/img.jfif'),
                  width: double.infinity,
                ),
                Container(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "الخدمات لمتاحة",
                  style: TextStyle(fontSize: 30, color: Colors.amber.shade500),
                )),
                Container(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber.shade500),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            side: BorderSide(
                                                color: Colors.blue.shade900)))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ExhabitProducts(
                                            Exhabit: '${currentUser.fullName}',
                                          )));
                                },
                                icon: Icon(Icons.ac_unit),
                                label: Text(
                                  "المنتجات",
                                )),
                          ),
                        )),
                        Expanded(
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber.shade500),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            side: BorderSide(
                                                color: Colors.blue.shade900)))),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ExhabitCarts(
                                            Exhabit: '${currentUser.fullName}',
                                          )));
                                },
                                icon: Icon(Icons.ac_unit),
                                label: Text("طلبات الشراء")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
