import 'package:HouseCleaning/Home/NavigationHomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'VerifyPhone.dart';
import 'numeric_pad.dart';

class LoginPhonePage extends StatefulWidget {
  @override
  _LoginPhonePageState createState() => _LoginPhonePageState();
}

var dataUser;

class _LoginPhonePageState extends State<LoginPhonePage> {
  String phoneNumber = "";
  bool status = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getData() {
    firestore
        .collection("users")
        .doc(phoneNumber.toString().startsWith("0")
            ? phoneNumber.substring(1)
            : phoneNumber)
        .get()
        .then((querySnapshot) {
      dataUser = querySnapshot.data();
      print(dataUser);
      print(status);
      if (dataUser == null) {
        setState(() {
          status = true;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyPhone(
                    phoneNumber: phoneNumber.toString().startsWith("0")
                        ? phoneNumber.substring(1)
                        : phoneNumber)),
          );
        });
      } else {
        setState(() {
          status = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                    phoneNumber: phoneNumber.toString().startsWith("0")
                        ? phoneNumber.substring(1)
                        : phoneNumber)),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => MainPage(
          //           phoneNumber: phoneNumber.toString().startsWith("0")
          //               ? phoneNumber.substring(1)
          //               : phoneNumber)),
          // );
        });
      }
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();

    // print(s.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.close,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          "Bạn nhập số điện thoại của mình",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFF7F7F7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/holding-phone.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 64),
                    child: Text(
                      "Bạn sẽ nhận được một mã gồm 6 số để xác minh ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF818181),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Nhập số điện thoại",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (phoneNumber.length > 10) {
                          Toast.show("Số điện thoại không tồn tại", context,
                              textColor: Colors.red,
                              backgroundColor: Colors.grey,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.TOP);
                        } else {
                          getData();
                          // status == true
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => MainPage()),
                          //       )
                          //     : Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => VerifyPhone(
                          //                 phoneNumber: phoneNumber
                          //                         .toString()
                          //                         .startsWith("0")
                          //                     ? phoneNumber.substring(1)
                          //                     : phoneNumber)),
                          //       );
                        }
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
                            "Nhận mã",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              setState(() {
                if (value != -1) {
                  phoneNumber = phoneNumber + value.toString();
                } else {
                  phoneNumber =
                      phoneNumber.substring(0, phoneNumber.length - 1);
                }
              });
            },
          ),
        ],
      )),
    );
  }
}
