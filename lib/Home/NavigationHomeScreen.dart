import 'dart:io';

import 'package:HouseCleaning/market/marketPage.dart';
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
  @override
  void initState() {
    super.initState();
    setuoNotification();
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
              ? Center(child: HomePageV2(phoneNumber: widget.phoneNumber))
              : Container(),
          bottomIcons == BottomIcons.Favorite
              ? Center(child: MarketPage())
              : Container(),
          bottomIcons == BottomIcons.Search
              ? Center(child: MyHomePage())
              : Container(),
          bottomIcons == BottomIcons.Account
              ? Center(child: MyHomePage())
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
                      text: "Hôm nay"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Favorite;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Favorite ? true : false,
                      icons: FontAwesomeIcons.shippingFast,
                      text: "Đi chợ"),
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
