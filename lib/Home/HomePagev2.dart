import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class HomePageV2 extends StatefulWidget {
  final String phoneNumber;

  HomePageV2({@required this.phoneNumber});
  @override
  _HomePageV2State createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  List data;
  List datas;
  // final TextEditingController _searchQuery = new TextEditingController();
  Future<String> _makeGetRequest() async {
    // tạo GET request
    String url = 'https://jsonplaceholder.typicode.com/users';
    Response response = await get(url);
    // data sample trả về trong response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    this.setState(() {
      data = json.decode(response.body);
      datas = data;
      print(data);
    });
    // Thực hiện convert json to object...
  }

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
      dataUser = querySnapshot.data();
    });
  }

  bool loading = false;
  Timer timer;
  void timerLoading() {
    setState(() {
      loading = true;
      timer?.cancel();
      print(loading);
    });
  }

  // something like 2013-04-20
  var now = DateTime.now();
  @override
  void initState() {
    this._makeGetRequest();
    getData();
    timerLoading();
    // timer = Timer.periodic(Duration(seconds: 3), (Timer t) => timerLoading());
  }

  Widget build(BuildContext context) {
    print(now.hour);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: GestureDetector(
          child: Image.asset(
            'assets/images/avatar.jpg',
            width: 30.0,
            height: 20.0,
          ),
        ),
        centerTitle: false,
        title: Text(
          dataUser == null ? " " : dataUser['full_name'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        textTheme: Theme.of(context).textTheme,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20.0),
            child: Text(
              formatDate(now, [dd, '-', mm, '-', yyyy]),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bảng chi tiêu trong tháng " + now.month.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("1221");
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        "Chi tiết",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue[300],
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 20,
                        color: Colors.blue[300],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              // width: 100.0,
              height: 170.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(children: [
                                Text(
                                  "Tiền đã tiêu",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/tientieu.png',
                                      width: 30.0,
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Text("100.000 Đ"),
                                  ],
                                )
                              ])
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                left: BorderSide(
                              color: Colors.red,
                              width: 3.0,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 80.0,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Column(children: [
                                Text(
                                  "Tiền Còn lại",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/tientieu.png',
                                      width: 30.0,
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Text("100.000 Đ"),
                                  ],
                                )
                              ])
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                left: BorderSide(
                              color: Colors.blue,
                              width: 3.0,
                            )),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(children: [
                                Text(
                                  "Tiền tháng " + now.month.toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/tientieu.png',
                                      width: 30.0,
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Text("100.000 Đ"),
                                  ],
                                )
                              ])
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                left: BorderSide(
                              color: Colors.green,
                              width: 3.0,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: 80.0,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Column(children: [
                                Text(
                                  "Tiền tháng " + now.month.toString(),
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/tientieu.png',
                                      width: 30.0,
                                      height: 20.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Text("100.000 Đ"),
                                  ],
                                )
                              ])
                            ],
                          ),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                left: BorderSide(
                              color: Colors.orange,
                              width: 3.0,
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(80.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: now.hour >= 10
                          ? Text(
                              "Trưa nay ăn gì",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15.0),
                            )
                          : now.hour >= 15
                              ? Text(
                                  "Tối nay ăn gì",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                )
                              : Text(
                                  "Sáng nay ăn gì",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print("1221");
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Nhiều lựa chọn hơn ",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 20,
                          color: Colors.blue[300],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: datas == null ? 0 : datas.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Card(
                          color: Colors.grey[100],
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => InformationPitch(
                              //               data: datas[index],
                              //             )));
                            },
                            child: Container(
                              width: 150.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        "assets/images/monnhat.jpg",
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Món nhật",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0),
                                        )),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "kimpap",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "cơm trứng",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "cá rán",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "650",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 30.0),
                                            )),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "Kcal",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(255, 164, 128, 1),
                                        Color.fromRGBO(247, 114, 62, 1),
                                      ]),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(80.0),
                                    bottomLeft: const Radius.circular(10.0),
                                    bottomRight: const Radius.circular(10.0),
                                  )),
                            ),
                          ),
                        ),
                      )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      child: now.hour >= 10
                          ? Text(
                              "Bữa ăn healthy cho buổi trưa",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15.0),
                            )
                          : now.hour >= 15
                              ? Text(
                                  "Bữa ăn healthy cho buổi tối",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                )
                              : Text(
                                  "Bữa ăn healthy cho buổi sáng",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0),
                                )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        print("1221");
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "Nhiều lựa chọn hơn",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.blue[300],
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 20,
                          color: Colors.blue[300],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              height: 200,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: datas == null ? 0 : datas.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Card(
                          color: Colors.grey[100],
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => InformationPitch(
                              //               data: datas[index],
                              //             )));
                            },
                            child: Container(
                              width: 150.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        "assets/images/monnhat.jpg",
                                        width: 50.0,
                                        height: 50.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Món nhật",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0),
                                        )),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "kimpap",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "cơm trứng",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "cá rán",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.0),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "650",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 30.0),
                                            )),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "Kcal",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.0),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              decoration: new BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(255, 164, 128, 1),
                                        Color.fromRGBO(247, 114, 62, 1),
                                      ]),
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(80.0),
                                    bottomLeft: const Radius.circular(10.0),
                                    bottomRight: const Radius.circular(10.0),
                                  )),
                            ),
                          ),
                        ),
                      )),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
