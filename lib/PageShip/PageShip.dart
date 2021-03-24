import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'FadeAnimation.dart';
import 'HomeShipPage.dart';
import 'Login.dart';
import 'ShipComponent.dart';

class ShipPage extends StatefulWidget {
  final String phoneNumber;

  ShipPage({@required this.phoneNumber});
  @override
  _ShipPageState createState() => _ShipPageState();
}

class _ShipPageState extends State<ShipPage> {
  final phoneLoginController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  @override
  Widget build(BuildContext context) {
    print(widget.phoneNumber);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/imageship.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3.6),
            ),
            Column(
              children: <Widget>[
                ///holds email header and inputField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40, bottom: 10),
                      child: Text(
                        "Nhập mã xác nhận ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 40, bottom: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Material(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30.0),
                                      topRight: Radius.circular(0.0))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 40, right: 20, top: 10, bottom: 10),
                                child: TextField(
                                  controller: phoneLoginController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Nhập mã",
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 50),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Text(
                                    'Xác nhận mã được gửi về tin nhắn điện thoại',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                                GestureDetector(
                                    onTap: () {
                                      _btnPushOtp(phoneLoginController.text);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: ShapeDecoration(
                                        shape: CircleBorder(),
                                        gradient: LinearGradient(
                                            colors: signInGradients,
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight),
                                      ),
                                      child: Icon(FontAwesomeIcons.addressBook),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ) /* add child content here */,
      ),
    );
  }

  _btnPushOtp(pin) async {
    print(pin);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeShipPage(
                        phoneNumber: widget.phoneNumber.toString(),
                      )),
              (route) => false);
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      _scaffoldkey.currentState
          .showSnackBar(SnackBar(content: Text('invalid OTP')));
    }
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+84 ${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeShipPage(
                            phoneNumber: widget.phoneNumber.toString(),
                          )),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}
