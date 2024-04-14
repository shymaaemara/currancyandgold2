import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../models/Product_model.dart';
import 'Exhabit_Addproducts.dart';

class ExhabitProducts extends StatefulWidget {
  final String Exhabit;
  static const routeName = '/ExhabitProducts';
  const ExhabitProducts({super.key, required this.Exhabit});

  @override
  State<ExhabitProducts> createState() => _ExhabitProductsState();
}

class _ExhabitProductsState extends State<ExhabitProducts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Product> ProductList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetcheproduct();
  }

  @override
  void fetcheproduct() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("product").child("${widget.Exhabit}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Product p = Product.fromJson(event.snapshot.value);
      ProductList.add(p);
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
              leading: BackButton(color: Colors.black),
              title: Text('المنتجات', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.amber.shade500,
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber.shade500,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ExhabitAddproducts(
                              Exhabit: '${widget.Exhabit}',
                            )));
              },
              child: Icon(Icons.add),
            ),
            body: Container(
              child: Container(
                color: Colors.black,
                child: Container(
                    width: double.infinity,
                    child: GridView.builder(
                        padding: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 15),
                        itemCount: ProductList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 5,
                            mainAxisExtent: 250),
                        itemBuilder: (context, i) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.amber.shade100,
                            child: Column(
                              children: [
                                Container(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: NetworkImage(
                                      '${ProductList[i].imageUrl.toString()}'),
                                ),
                                Container(
                                  height: 5,
                                ),
                                Text(
                                  '       ${ProductList[i].name.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.amber.shade700),
                                ),
                                Container(
                                  height: 3,
                                ),
                                Text(
                                  'العيار:   ${ProductList[i].caliber.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Container(
                                  height: 3,
                                ),
                                Text(' ${ProductList[i].gram.toString()} جرام ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                Container(
                                  height: 3,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                super.widget));
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child('product')
                                        .child("${widget.Exhabit}")
                                        .child('${ProductList[i].id}')
                                        .remove();
                                  },
                                  child: Icon(Icons.delete,
                                      color:
                                          Color.fromARGB(255, 122, 122, 122)),
                                )
                              ],
                            ),
                          );
                        })),
              ),
            )));
  }
}
