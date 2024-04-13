import 'package:currancyandgold2/models/Carts_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
                                          height: 30,
                                        ),
                                        Text(
                                          '  الاسم: ${cartList[i].name.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                          '  العنوان: ${cartList[i].address.toString()}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                        Text(
                                            '  الكميه :${cartList[i].number.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black)),
                                        Container(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(" التلفون",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                            Text(
                                                '  ${cartList[i].phone.toString()}    ',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                        Container(
                                          height: 20,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ExhabitCarts(
                                                          Exhabit:
                                                              '${widget.Exhabit}',
                                                        )));
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('Carts')
                                                .child("${widget.Exhabit}")
                                                .child('${cartList[i].id}')
                                                .remove();
                                          },
                                          child: Icon(Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 122, 122, 122)),
                                        )
                                      ])));
                            }))))));
  }
}
