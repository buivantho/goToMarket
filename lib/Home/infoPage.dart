import 'dart:io';

import 'package:HouseCleaning/Login/LoginPhone.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class InfoPage extends StatefulWidget {
  var dataUser;

  InfoPage({@required this.dataUser});
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  File avatarImageFile, backgroundImageFile;
  String sex;

  Future getImage(bool isAvatar) async {
    var result = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (isAvatar) {
        avatarImageFile = result;
      } else {
        backgroundImageFile = result;
      }
    });
  }

  var dataUser;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // void getData() async {
  //   print("widget.phoneNumber");
  //   firestore
  //       .collection("users")
  //       .doc(widget.phoneNumber.toString().startsWith("0")
  //           ? widget.phoneNumber.substring(1)
  //           : widget.phoneNumber)
  //       .get()
  //       .then((querySnapshot) {
  //     dataUser = querySnapshot.data();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getData();
    // timer = Timer.periodic(Duration(seconds: 3), (Timer t) => timerLoading());
  }

  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Stack(
              children: <Widget>[
                // Background
                (backgroundImageFile == null)
                    ? new Image.asset(
                        'images/bg_uit.jpg',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      )
                    : new Image.file(
                        backgroundImageFile,
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),

                // Button change background
                new Positioned(
                  child: new Material(
                    child: new IconButton(
                      icon: new Image.asset(
                        'images/ic_camera.png',
                        width: 30.0,
                        height: 30.0,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () => getImage(false),
                      padding: new EdgeInsets.all(0.0),
                      highlightColor: Colors.black,
                      iconSize: 30.0,
                    ),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  right: 5.0,
                  top: 5.0,
                ),

                // Avatar and button
                new Positioned(
                  child: new Stack(
                    children: <Widget>[
                      (avatarImageFile == null)
                          ? new Image.asset(
                              'images/ic_avatar.png',
                              width: 70.0,
                              height: 70.0,
                            )
                          : new Material(
                              child: new Image.file(
                                avatarImageFile,
                                width: 70.0,
                                height: 70.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(40.0)),
                            ),
                      new Material(
                        child: new IconButton(
                          icon: new Image.asset(
                            'images/ic_camera.png',
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () => getImage(true),
                          padding: new EdgeInsets.all(0.0),
                          highlightColor: Colors.black,
                          iconSize: 70.0,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(40.0)),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                  top: 115.0,
                  left: MediaQuery.of(context).size.width / 2 - 70 / 2,
                )
              ],
            ),
            width: double.infinity,
            height: 200.0,
          ),
          new Column(
            children: <Widget>[
              // Username
              new Container(
                child: new Text(
                  'Họ & Tên',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null
                        ? " "
                        : widget.dataUser['full_name'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),
              new Container(
                child: new Text(
                  'Phone',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null
                        ? " "
                        : widget.dataUser['phoneNumber'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),
              // Country
              new Container(
                child: new Text(
                  'Năm sinh',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null ? " " : widget.dataUser['birthday'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),
              // Address
              new Container(
                child: new Text(
                  'Giới tính',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null ? " " : widget.dataUser['sex'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),

              // About me
              new Container(
                child: new Text(
                  'Dịa chỉ',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null
                        ? " "
                        : widget.dataUser['Ward'] +
                            "," +
                            widget.dataUser['district'] +
                            "," +
                            widget.dataUser['city'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),

              // About me
              new Container(
                child: new Text(
                  'Địa chỉ giao hàng',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.amber),
                ),
                margin: new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                    widget.dataUser == null ? " " : widget.dataUser['address'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
                margin: new EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
              ),

              Container(
                height: 40.0,
                width: 100.0,
                padding: EdgeInsets.only(top: 10.0, left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPhonePage()));
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
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          )
        ],
      ),
      padding: new EdgeInsets.only(bottom: 20.0),
    );
  }
}
