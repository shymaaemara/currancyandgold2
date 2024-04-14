import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currancyandgold2/models/Carts_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../admin/admin_exhibition.dart';

class ExhabitCarts extends StatefulWidget {
  static const routeName = '/ExhabitCarts';

  String Exhabit;
  ExhabitCarts({super.key, required this.Exhabit});

  @override
  State<ExhabitCarts> createState() => _ExhabitCartsState();
}

class _ExhabitCartsState extends State<ExhabitCarts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Carts> cartList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCarts();
  }

  @override
  @override
  void fetchCarts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child('Carts').child('${widget.Exhabit}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Carts p = Carts.fromJson(event.snapshot.value);
      cartList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: Align(
                  alignment: Alignment.center,
                  child: Text("طلبات الشراء",
                      style: TextStyle(color: Colors.black))),
              backgroundColor: Colors.amber.shade500,
              actions: [],
            ),
            body: Container(
                child: Container(
                    color: Colors.black,
                    child: Container(
                        width: double.infinity,
                        child: GridView.builder(
                            padding: EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 15),
                            itemCount: cartList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5,
                                    mainAxisExtent: 250),
                            itemBuilder: (context, i) {
                              return InkWell(
                                  onTap: () {},
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.amber.shade100,
                                      child: Column(children: [
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '  الاسم: ${cartList[i].name.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '  العنوان : ${cartList[i].address.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Text(
                                          '  المنتج: ${cartList[i].product.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(" عيار:",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text(
                                                "${cartList[i].earat.toString()}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(" التلفون",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text(
                                                '  ${cartList[i].phone.toString()}    ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                              color: Colors.amber.shade500,
                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType: DialogType.info,
                                                  animType: AnimType.rightSlide,
                                                  desc: 'تمت الموافقه بنجاح',
                                                )..show();
                                              },
                                              child: Text(
                                                "موافقه ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              width: 15,
                                            ),
                                            MaterialButton(
                                              color: Colors.amber.shade500,
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            super.widget));
                                                FirebaseDatabase.instance
                                                    .reference()
                                                    .child('Carts')
                                                    .child("${widget.Exhabit}")
                                                    .child('${cartList[i].id}')
                                                    .remove();
                                              },
                                              child: Text("رفض",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        )
                                      ])));
                            }))))));
  }
}
