import 'package:currancyandgold2/screens/admin/Add_exhibition.dart';
import 'package:currancyandgold2/screens/admin/add_company.dart';
import 'package:currancyandgold2/screens/admin/add_currency.dart';
import 'package:currancyandgold2/screens/admin/add_gold.dart';
import 'package:currancyandgold2/screens/admin/admin_company.dart';
import 'package:currancyandgold2/screens/admin/admin_currency.dart';
import 'package:currancyandgold2/screens/admin/admin_exhibition.dart';
import 'package:currancyandgold2/screens/admin/admin_gold.dart';
import 'package:currancyandgold2/screens/admin/admin_home.dart';
import 'package:currancyandgold2/screens/admin/admin_login.dart';
import 'package:currancyandgold2/screens/auth/login.dart';
import 'package:currancyandgold2/screens/auth/reg.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_Addproducts.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_Carts.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_Exhabitions.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_home.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_login.dart';
import 'package:currancyandgold2/screens/exhabit/Exhabit_products.dart';
import 'package:currancyandgold2/screens/user/User_Exhabitions.dart';
import 'package:currancyandgold2/screens/user/homepage.dart';
import 'package:currancyandgold2/screens/user/openscreen.dart';
import 'package:currancyandgold2/screens/user/user_cart.dart';
import 'package:currancyandgold2/screens/user/user_company.dart';
import 'package:currancyandgold2/screens/user/user_currency.dart';
import 'package:currancyandgold2/screens/user/user_gold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const OpenScreen()
            : FirebaseAuth.instance.currentUser?.email == 'admin@gmail.com'
                ? const AdminHomePage()
                : FirebaseAuth.instance.currentUser?.displayName == 'معرض'
                    ? const CustomerHomePage()
                    : const OpenScreen(),
        routes: {
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          CustomerHomePage.routeName: (ctx) => CustomerHomePage(),
          AdminLogin.routeName: (ctx) => AdminLogin(),
          AdminHomePage.routeName: (ctx) => AdminHomePage(),
          AddGold.routeName: (ctx) => AddGold(),
          AdminGoldPage.routeName: (ctx) => AdminGoldPage(),
          OpenScreen.routeName: (ctx) => OpenScreen(),
          UserGoldPage.routeName: (ctx) => UserGoldPage(),
          AddCurrency.routeName: (ctx) => AddCurrency(),
          AdminCurrency.routeName: (ctx) => AdminCurrency(),
          UserCurrency.routeName: (ctx) => UserCurrency(),
          AddCompany.routeName: (ctx) => AddCompany(),
          AdminCompany.routeName: (ctx) => AdminCompany(),
          UserCompany.routeName: (ctx) => UserCompany(),
          AddExhibition.routeName: (ctx) => AddExhibition(),
          AdminExhibition.routeName: (ctx) => AdminExhibition(),
          ExhabitAddproducts.routeName: (ctx) => ExhabitAddproducts(
                Exhabit: '',
              ),
          ExhabitProducts.routeName: (ctx) => ExhabitProducts(
                Exhabit: '',
              ),
          ExhabitLogin.routeName: (ctx) => ExhabitLogin(),
          ExhabitExhabitions.routeName: (ctx) => ExhabitExhabitions(
                Exhabitname: '',
              ),
          ExhabitHome.routeName: (ctx) => ExhabitHome(),
          ExhabitCarts.routeName: (ctx) => ExhabitCarts(
                Exhabit: '',
              ),
          UserExhabition.routeName: (ctx) => UserExhabition(),
          UserCart.routeName: (ctx) => UserCart(
                Exhabit: '',
              ),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
