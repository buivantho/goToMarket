import 'dart:io';

import 'package:HouseCleaning/Home/infoPage.dart';
import 'package:HouseCleaning/market/marketPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'HomePage.dart';
import 'HomePagev2.dart';
import 'bottom_bar.dart';

class MainPage extends StatefulWidget {
  final String phoneNumber;

  MainPage({@required this.phoneNumber});

  @override
  _MainPageState createState() => _MainPageState();
}

enum BottomIcons { Home, Favorite, Search, Account }

class _MainPageState extends State<MainPage> {
  BottomIcons bottomIcons = BottomIcons.Home;
  var dataUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getData() {
    print("widget.phoneNumber");
    firestore
        .collection("users")
        .doc(widget.phoneNumber.toString().startsWith("0")
            ? widget.phoneNumber.substring(1)
            : widget.phoneNumber)
        .get()
        .then((querySnapshot) {
      setState(() {
        dataUser = querySnapshot.data();
      });
    });
  }

  void getUserShip() {
    FirebaseFirestore.instance
        .collection('account')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  print(doc.data());
                });
              }),
            });
  }

  @override
  void initState() {
    super.initState();
    setuoNotification();
    getData();
    print(dataUser);
    print("dataUser");
    getUserShip();
  }

  void setuoNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging();
    Future initialise() async {
      if (Platform.isIOS) {
        _fcm.requestNotificationPermissions(IosNotificationSettings());
      }
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) {
          print('onMessage : $message');
        },
        onLaunch: (Map<String, dynamic> message) {
          print('onLaunch : $message');
        },
        onResume: (Map<String, dynamic> message) {
          print('onResume : $message');
        },
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.Home
              ? Center(
                  child: HomePageV2(
                  dataUser: dataUser,
                ))
              : Container(),
          bottomIcons == BottomIcons.Favorite
              ? Center(
                  child: MarketPage(
                  dataUser: dataUser,
                ))
              : Container(),
          bottomIcons == BottomIcons.Search
              ? Center(child: MyHomePage())
              : Container(),
          bottomIcons == BottomIcons.Account
              ? Center(
                  child: InfoPage(
                  dataUser: dataUser,
                ))
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 14, right: 14, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Home;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Home ? true : false,
                      icons: EvaIcons.home,
                      text: "TRANG CHỦ"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Favorite;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Favorite ? true : false,
                      icons: FontAwesomeIcons.shippingFast,
                      text: "ĐẶT ĐỒ"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Search;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Search ? true : false,
                      icons: EvaIcons.search,
                      text: "Search"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Account;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Account ? true : false,
                      icons: EvaIcons.personOutline,
                      text: "Account"),
                ],
              ),
            ),
          )
        ],
      ),
     
    );
  }
}
