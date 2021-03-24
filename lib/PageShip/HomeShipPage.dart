import 'package:HouseCleaning/Home/HomePage.dart';
import 'package:HouseCleaning/Home/bottom_bar.dart';
import 'package:HouseCleaning/PageShip/information_ship.dart';
import 'package:HouseCleaning/PageShip/statistical.dart';
import 'package:HouseCleaning/market/marketPage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'AreDelivered.dart';
import 'ShipComponent.dart';

class HomeShipPage extends StatefulWidget {
  final String phoneNumber;

  HomeShipPage({@required this.phoneNumber});
  @override
  _HomeShipPageState createState() => _HomeShipPageState(phoneNumber);
}

enum BottomIcons { Home, Favorite, Search, Account }

class _HomeShipPageState extends State<HomeShipPage> {
  var phoneNumber;
  _HomeShipPageState(this.phoneNumber);
  BottomIcons bottomIcons = BottomIcons.Home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.Home
              ? Center(child: ShipComponent(phoneNumber: phoneNumber))
              : Container(),
          bottomIcons == BottomIcons.Favorite
              ? Center(child: AreDelivered(phoneNumber: phoneNumber))
              : Container(),
          bottomIcons == BottomIcons.Search
              ? Center(child: Statistical(phoneNumber: phoneNumber))
              : Container(),
          bottomIcons == BottomIcons.Account
              ? InformationShip(phoneNumber: phoneNumber)
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
                      text: "ĐƠN HÀNG"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Favorite;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Favorite ? true : false,
                      icons: FontAwesomeIcons.shippingFast,
                      text: "ĐANG GIAO"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Search;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Search ? true : false,
                      icons: EvaIcons.search,
                      text: "Thông tin"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Account;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Account ? true : false,
                      icons: EvaIcons.personOutline,
                      text: "Tài khoản"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
