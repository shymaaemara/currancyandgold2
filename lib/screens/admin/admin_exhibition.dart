import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


import '../../models/exhibit_model.dart';
import 'Add_exhibition.dart';
class AdminExhibition extends StatefulWidget {
  static const routeName = '/AdminExhibition';
  const AdminExhibition({super.key});

  @override
  State<AdminExhibition> createState() => _AdminExhibitionState();
}

class _AdminExhibitionState extends State<AdminExhibition> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Exhibit> ExhibitList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchexhibittions();
  }
  @override

  @override
  void fetchexhibittions() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("exhibittions");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Exhibit p = Exhibit.fromJson(event.snapshot.value);
      ExhibitList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber.shade500,
            onPressed: () {
              Navigator.pushNamed(context, AddExhibition.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: Container(child: Container(
    color: Colors.black,
    child:  Container(
        width: double.infinity,
        child: GridView.builder(
            padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 15
            ),
            itemCount: ExhibitList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 5,mainAxisExtent: 250), itemBuilder: (context,i){
          return

            Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.amber.shade500,

              child: Column(children: [
                CircleAvatar(
                  radius: 37,
                  backgroundImage: NetworkImage(
                      '${ExhibitList[i].imageUrl.toString()}'),
                ),

                Text(
                  '${ExhibitList[i].name.toString()}',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                ),


                Text('${ExhibitList[i].email.toString()}'),


                Text(
                    'كلمة المرور: ${ExhibitList[i].password.toString()}'),





                Text(
                    'الهاتف: ${ExhibitList[i].phone.toString()}'),

                Container(
                    child: Text('${ExhibitList[i].address.toString()}')),
                InkWell(
                  onTap: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AdminExhibition()));
                    FirebaseDatabase.instance
                        .reference()
                        .child('Exhabitions')
                        .child('$ExhibitList[i].id}')
                        .remove();
                  },
                  child: Icon(Icons.delete,
                      color: Color.fromARGB(255, 122, 122, 122)),
                )
              ],),

            )

          ;
        }

        )),
            ),
          ) ) );
  }
}
