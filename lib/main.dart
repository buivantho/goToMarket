import 'package:HouseCleaning/market/historyOder.dart';
import 'package:HouseCleaning/services/Tests.dart';
import 'package:HouseCleaning/shipPage/ScanScreen.dart';
import 'package:HouseCleaning/shipPage/shipPape.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home/HomePagev2.dart';
import 'Home/NavigationHomeScreen.dart';
import 'Login/FormPage.dart';
import 'Login/LoginPhone.dart';
import 'Login/ProfilePage.dart';
import 'PageShip/HomeShipPage.dart';
import 'PageShip/PageShip.dart';
import 'PageShip/ShipComponent.dart';
import 'market/historyOders.dart';
import 'market/marketPage.dart';
import 'market/oder.dart';
import 'market/orderPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // textTheme: TextTheme(bodyText2: TextStyle(color: Colors.purple)),
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.rubikTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPhonePage(),
    );
  }
}
