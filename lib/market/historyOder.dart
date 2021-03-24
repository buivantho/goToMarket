import 'package:HouseCleaning/market/oder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'historyOders.dart';

class HistoryOder extends StatefulWidget {
  var dataUser;

  HistoryOder({@required this.dataUser});
  @override
  _HistoryOderState createState() => _HistoryOderState();
}

bool statusAppBar = true;
var dataUser;

class _HistoryOderState extends State<HistoryOder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new GradientAppBar(
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.cartArrowDown,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 40.0,
                  padding: EdgeInsets.only(top: 10.0, left: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: statusAppBar == true ? Colors.orange : Colors.grey,
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusAppBar = true;
                      });
                    },
                    child: Text(
                      "GIỎ HÀNG",
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
                      color:
                          statusAppBar == false ? Colors.orange : Colors.grey,
                      border: Border.all(color: Colors.blueAccent, width: 2)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        statusAppBar = false;
                      });
                    },
                    child: Text(
                      "ĐƠN HÀNG",
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
        body: statusAppBar == true
            ? Oder(
                dataUser: widget.dataUser,
              )
            : HistoryOders(
                dataUser: widget.dataUser,
              ));
  }
}
