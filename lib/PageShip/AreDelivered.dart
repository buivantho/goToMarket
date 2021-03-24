import 'package:HouseCleaning/market/historyOder.dart';
import 'package:HouseCleaning/market/historyOders.dart';
import 'package:HouseCleaning/market/oder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'AreShipping.dart';
import 'ByDate.dart';
import 'DeliveryHistory.dart';

class AreDelivered extends StatefulWidget {
  final String phoneNumber;

  AreDelivered({@required this.phoneNumber});
  @override
  _AreDeliveredState createState() => _AreDeliveredState(phoneNumber);
}

var id_user = "";
var service = [];
var indexService;
var objIdService = [];
var statusbar = 0;

class _AreDeliveredState extends State<AreDelivered> {
  var phoneNumber;

  _AreDeliveredState(this.phoneNumber);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new GradientAppBar(
          // leading: IconButton(
          //   icon: Icon(
          //     FontAwesomeIcons.cartArrowDown,
          //     color: Colors.white,
          //     size: 20.0,
          //   ),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 40.0,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: statusbar == 0 ? Colors.orange : Colors.grey,
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusbar = 0;
                      });
                    },
                    child: Text(
                      "ĐANG GIAO",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  width: 100.0,
                  height: 40.0,
                  padding: EdgeInsets.only(top: 10.0, left: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: statusbar == 1 ? Colors.orange : Colors.grey,
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusbar = 1;
                      });
                    },
                    child: Text(
                      "THEO NGÀY",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  height: 40.0,
                  width: 100.0,
                  padding: EdgeInsets.only(top: 10.0, left: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: statusbar == 2 ? Colors.orange : Colors.grey,
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusbar = 2;
                      });
                    },
                    child: Text(
                      "ĐÃ GIAO",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 164, 128, 1),
                Color.fromRGBO(247, 114, 62, 1),
              ]),
        ),
        body: statusbar == 0
            ? AreShipping(
                phoneNumber: phoneNumber,
              )
            : statusbar == 1
                ? ByDate(
                    phoneNumber: phoneNumber,
                  )
                : DeliveryHistory(
                    phoneNumber: phoneNumber,
                  ));
  }
}
