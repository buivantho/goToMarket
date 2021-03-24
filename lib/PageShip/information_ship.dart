import 'package:HouseCleaning/Login/LoginPhone.dart';
import 'package:flutter/material.dart';

class InformationShip extends StatefulWidget {
  final String phoneNumber;

  InformationShip({@required this.phoneNumber});
  @override
  _InformationShipState createState() => _InformationShipState(phoneNumber);
}

class _InformationShipState extends State<InformationShip> {
  var phoneNumber;

  _InformationShipState(this.phoneNumber);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 100.0,
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginPhonePage()));
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFDC3D),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              "Đăng xuất",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
