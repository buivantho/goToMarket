import 'dart:async';

import 'package:HouseCleaning/market/viewOderBookMaryDays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryOders extends StatefulWidget {
  var dataUser;

  HistoryOders({@required this.dataUser});
  @override
  _HistoryOdersState createState() => _HistoryOdersState();
}

var historyOder = [];
var oder;
var historyOderID = [];
var dataUser;

class _HistoryOdersState extends State<HistoryOders> {
  void getData() {
    oder = null;
    // firestore.collection("maker").get().then((QuerySnapshot snapshot) {
    //   print(snapshot.docs);
    // });
    // firestore.collection("users").doc().get().then((querySnapshot) {
    //   setState(() {
    //     dataMaker = querySnapshot.data();
    //     print(dataMaker);
    //   });
    // });
    // firestore.collection("maker").get().then((QuerySnapshot snapshot) {
    //   print(snapshot.docs);
    //   print("snapshot.docs");
    //   snapshot.docs.forEach((f) => print('${f.data}}'));
    // });
    // print("123123123123123123123123123123123");
    // firestore.collection('users').get().then((QuerySnapshot querySnapshot) => {
    //       querySnapshot.docs.forEach((doc) {
    //         print(doc);
    //       })
    //     });
    historyOder = [];
    historyOderID = [];
    print(widget.dataUser);
    FirebaseFirestore.instance
        .collection('products')
        .doc(widget.dataUser['phoneNumber'])
        //.doc("327966333")
        .collection('datas')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  if (doc.data()['status'] > 0) {
                    oder = doc.data();
                  } else {
                    historyOder.add(doc.data());
                    historyOderID.add(doc.id);
                    print(historyOder);
                  }
                  // print(historyOderID[2]);
                });
              }),
            });
  }

  @override
  void initState() {
    super.initState();

    getData();
    Timer.periodic(new Duration(seconds: 60), (timer) {
      getData();
    });
    // _buildRatingStars("87654321");

    // checkBox(true);
    // priceSum();
    // dataMarket = liveFood;
    // this._makeGetRequest();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width * 10,
          height: MediaQuery.of(context).size.height * 10,
          child: Column(
            children: [
              oder == null
                  ? Container(child: Text(""))
                  : Container(
                      height: 380.0,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2.0, color: Colors.black),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text("MÃ ĐƠN HÀNG"),
                          Text(oder['service_code']),
                          GestureDetector(
                            onTap: () {
                              launch("tel://" + "0327966332");
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 150.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100.0)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(255, 164, 128, 1),
                                            Color.fromRGBO(247, 114, 62, 1),
                                          ]),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/avatar.jpg',
                                          width: 40.0,
                                          height: 30.0,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 3.0,
                                            ),
                                            Text("Bùi văn thọ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text("0327966332",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ],
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: oder['status'] == 1
                                          ? Image.asset(
                                              'assets/images/nauan.gif',
                                              width: 120.0,
                                              height: 120.0,
                                            )
                                          : Container(
                                              width: 120.0,
                                              height: 120.0,
                                            )),
                                  Text("Đang chuẩn bị",
                                      style: oder['status'] == 1
                                          ? TextStyle(
                                              color: Colors.orange[400],
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)
                                          : TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: oder['status'] == 2
                                          ? Image.asset(
                                              'assets/images/giaohang.gif',
                                              width: 120.0,
                                              height: 125.0,
                                            )
                                          : Container(
                                              width: 120.0,
                                              height: 125.0,
                                            )),
                                  Text("Đang giao hàng",
                                      style: oder['status'] == 2
                                          ? TextStyle(
                                              color: Colors.orange[400],
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)
                                          : TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: oder['status'] == 3
                                          ? Image.asset(
                                              'assets/images/gocua.gif',
                                              width: 120.0,
                                              height: 125.0,
                                            )
                                          : Container(
                                              width: 120.0,
                                              height: 125.0,
                                            )),
                                  Text("Đã giao đến",
                                      style: oder['status'] == 3
                                          ? TextStyle(
                                              color: Colors.orange[400],
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)
                                          : TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 150.0,
                            child: ListView.builder(
                              itemCount: oder['items_oder'] == null
                                  ? 0
                                  : oder['items_oder'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/loadingss.png",
                                          width: 50.0,
                                          height: 50.0,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                          height: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 210,
                                                  child: Text(
                                                    oder['items_oder'][index]
                                                        ["name_maker"],
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Text(
                                                  oder['items_oder'][index]
                                                          ["price"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Số lượng: " +
                                                  oder['items_oder'][index]
                                                          ["qty"]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
              Container(
                height: oder == null
                    ? MediaQuery.of(context).size.height * 0.8
                    : 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: historyOder == null ? 0 : historyOder.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 17.0),
                              child: Text(
                                historyOder[index]['items_oder']
                                    .length
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue[300]),
                              )),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                                "Mã đơn: " +
                                    historyOder[index]['service_code']
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  "Thời gian: " +
                                      historyOder[index]['time_oder']
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            Text(
                                "Đơn giá: " +
                                    historyOder[index]['price'].toString() +
                                    "/   " +
                                    historyOder[index]['paymentType'],
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                      "Đơn giá: " +
                                          historyOder[index]['price']
                                              .toString() +
                                          "/" +
                                          historyOder[index]['paymentType'] +
                                          "/",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  Text(
                                    historyOder[index]['status'] == 0
                                        ? "Đợi xác nhận"
                                        : historyOder[index]['status'] == 1
                                            ? "Đang chuẩn bị đò ăn"
                                            : historyOder[index]['status'] == 2
                                                ? "Đang giao hàng"
                                                : historyOder[index]
                                                            ['status'] ==
                                                        3
                                                    ? "Giao hàng thành công"
                                                    : "",
                                    style: TextStyle(
                                        color: historyOder[index]['status'] == 0
                                            ? Colors.red
                                            : historyOder[index]['status'] == 1
                                                ? Colors.yellow
                                                : historyOder[index]
                                                            ['status'] ==
                                                        2
                                                    ? Colors.lightBlue
                                                    : historyOder[index]
                                                                ['status'] ==
                                                            3
                                                        ? Colors.brown
                                                        : "",
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: IconButton(
                        //     icon: Icon(
                        //       FontAwesomeIcons.plus,
                        //       size: 20.0
                        //     ),
                        //     color: Colors.orange,
                        //     onPressed: () {

                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewOderBookMaryDays(
                          dataUser: widget.dataUser,
                        )));
          });
        },
        label: const Text('Nhiều ngày'),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
