import 'dart:async';

import 'package:HouseCleaning/market/timeBookManyDays.dart';
import 'package:calendarro/calendarro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class Oder extends StatefulWidget {
  var dataUser;

  Oder({@required this.dataUser});
  @override
  _OderState createState() => _OderState();
}

var historyOder = [];
var historyOderID = [];
var oder = [];
var objIndex = [];
var addressEdit;
var index;
var indexPay;
int sumPrice = 0;
int priceShip = 15000;
int allPriceService = 0;
var sumPriceConver = 0;
bool tuVal = true;
bool statusSaveTime = false;
var dataUser;
// var f = new DateFormat('yyyy-MM-dd hh:mm');
var val;
var timeOder;
var now = new DateTime.now();
var paymentType = 'Tiền mặt';
GlobalKey myFormKey = new GlobalKey();

class _OderState extends State<Oder> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var dataUser;
  final address = TextEditingController();
  void getData() {
    timer?.cancel();
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
    timer?.cancel();
    FirebaseFirestore.instance
        .collection('addToBasket')
        // .doc("327966332")
        .doc(widget.dataUser['phoneNumber'])
        .collection('datas')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  historyOder.add(doc.data());
                  historyOderID.add(doc.id);
                  // print(historyOder);

                  // print(historyOderID[2]);
                });
              }),
              priceSum(historyOder)
            });
    priceSum(historyOder);
  }

  void priceSum(historyOder) {
    for (var i = 0; i < historyOder.length; i++) {
      sumPrice = historyOder[i]['price'] + sumPrice;
    }
    allPriceService = sumPrice + priceShip;
    // sumPriceConver = sumPrice;
    // // sumPriceConver.toString().substring(1, 3);
    // print(sumPriceConver.toString().substring(2, 3));
    // print(sumPriceConver.toString().substring(2, 3));
  }

  void deleteItemOder(indexs) {
    FirebaseFirestore.instance
        .collection("addToBasket")
        .doc(widget.dataUser['phoneNumber'])
        .collection('datas')
        .document(historyOderID[indexs])
        .delete();
  }

  void checkBox(value, index) {
    print(index);
    if (value == false) {
      historyOder[index]['active'] = false;

      sumPrice = sumPrice - historyOder[index]['price'];
      objIndex.add(index);
    } else {
      historyOder[index]['active'] = true;
      sumPrice = sumPrice + historyOder[index]['price'];
      objIndex.remove(index);
      // priceSum(historyOder);
    }

    allPriceService = sumPrice + priceShip;
  }

  void pushIdToData() {
    timer?.cancel();
    for (var i = 0; i < historyOder.length; i++) {
      historyOder[i]["id"] = historyOderID[i];
    }
    print(historyOder);
    // print(historyOderID);
  }

  void getUserShip() {
    FirebaseFirestore.instance
        .collection('account')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  print(doc.data());
                });
              }),
            });
  }

  void comeBack() {
    setState(() {
      statusSaveTime = false;
      myDateRange = null;
    });
  }

  Timer timer;
  // SearchBar searchBar;
  @override
  void initState() {
    super.initState();
    // testdata();
    getUserShip();
    allPriceService = 0;
    sumPrice = 0;
    objIndex = [];
    comeBack();
    // _buildRatingStars("87654321");
    getData();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => pushIdToData());
    // checkBox(true);
    // priceSum();
    // dataMarket = liveFood;
    // this._makeGetRequest();
  }

  DateTimeRange myDateRange;

  String dropdownValue = 'Tiền mặt';
  Widget build(BuildContext context) {
    print(sumPrice);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Giao tới",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Container(
                color: Colors.white,
                child: Column(children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapMarked,
                        color: Colors.orange,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50.0,
                          child: Text(
                            addressEdit == null
                                ? widget.dataUser['address'] +
                                    "," +
                                    widget.dataUser['Ward'] +
                                    "," +
                                    widget.dataUser['district'] +
                                    "," +
                                    widget.dataUser['city']
                                : addressEdit.toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Container(
                      color: Colors.grey[200],
                      child: TextField(
                        style: TextStyle(fontSize: 17.0, color: Colors.black),
                        controller: address,
                        decoration: new InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(FontAwesomeIcons.save),
                            onPressed: () {
                              setState(() {
                                addressEdit = address.text;
                                address.clear();
                              });
                            },
                          ),
                          hintMaxLines: null,
                          // hintText: "Enter your email",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600),
                          hintText:
                              "Địa chỉ giao hàng chi tiết, ghi chú cho tài xế",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thời gian giao hàng",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                statusSaveTime == true
                    ? GestureDetector(
                        onTap: () {
                          comeBack();
                        },
                        child: Row(
                          children: [
                            Text("Đặt trong ngày",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimeBookManyDays(
                                        dataUser: widget.dataUser,
                                      )));
                        },
                        child: Row(
                          children: [
                            Text("Đặt nhiều ngày",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
              ],
            ),
          ),
          statusSaveTime == true
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: 100.0,
                    color: Colors.white,
                    child: Text(
                        myDateRange.toString().substring(0, 10) +
                            " - " +
                            myDateRange.toString().substring(26, 36),
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    color: Colors.white,
                    child: DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      dateMask: 'd MMM, yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date',
                      timeLabelText: "Hour",
                      selectableDayPredicate: (date) {
                        // Disable weekend days to select from the calendar
                        if (date.weekday == 6 || date.weekday == 7) {
                          return false;
                        }

                        return true;
                      },
                      onChanged: (val) => timeOder = val,
                      validator: (val) {
                        // setState(() {
                        //   timeOder = val;
                        // });
                        print(val);
                        return val;
                      },
                      onSaved: (val) => print(val),
                      // timeOder = val}
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tóm tắt đơn hàng",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text("Thêm món",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue[400],
                        fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.white,
              height: 200.0,
              child: ListView.builder(
                key: index,
                itemCount: historyOder == null ? 0 : historyOder.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      background: Container(
                        color: Colors.blue,
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          print(index);
                          print(historyOderID[index]);
                          deleteItemOder(index);
                          historyOder.removeAt(historyOder[index]);
                        });
                      },
                      key: ValueKey(historyOder.elementAt(index)),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Checkbox(
                                  value: historyOder[index]['active'],
                                  onChanged: (bool value) {
                                    setState(() {
                                      checkBox(value, index);
                                      tuVal = historyOder[index]['active'];
                                    });
                                  },
                                ),
                              ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 210,
                                        child: Text(
                                          historyOder[index]["name_maker"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        historyOder[index]["price"].toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Số lượng: " +
                                        historyOder[index]["qty"].toString(),
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
                      ));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.5, left: 8.0, right: 8.0),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tổng tạm tính",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Text(sumPrice.toString() + "đ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[400],
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5, left: 8.0, right: 8.0),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Phí giao hàng",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Text(priceShip.toString() + "đ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue[400],
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Thông tin hóa đơn",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.5, left: 8.0, right: 8.0),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Bằng thẻ', 'Tiền mặt', 'Bằng ví', 'momo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        key: indexPay,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                value == "Bằng thẻ"
                                    ? FontAwesomeIcons.creditCard
                                    : value == 'Tiền mặt'
                                        ? FontAwesomeIcons.moneyBill
                                        : value == 'Bằng ví'
                                            ? FontAwesomeIcons.wallet
                                            : value == 'momo'
                                                ? FontAwesomeIcons.mobileAlt
                                                : FontAwesomeIcons.wallet,
                                size: 25.0,
                                color: Colors.green[300],
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            paymentType = value;
                          });
                        },
                      );
                    }).toList(),
                  )),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng cộng",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600)),
                        Text(allPriceService.toString() + "đ",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              order();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(255, 164, 128, 1),
                                    Color.fromRGBO(247, 114, 62, 1),
                                  ]),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50.0,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ĐẶT ĐƠN",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(50),
                        //       gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomCenter,
                        //           colors: [
                        //             Color.fromRGBO(255, 164, 128, 1),
                        //             Color.fromRGBO(247, 114, 62, 1),
                        //           ]),
                        //     ),
                        //     width: MediaQuery.of(context).size.width * 0.4,
                        //     height: 50.0,
                        //     child: Align(
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           "ĐẶT THEO NGÀY",
                        //           style: TextStyle(
                        //               fontSize: 20.0,
                        //               color: Colors.white,
                        //               fontWeight: FontWeight.w600),
                        //         )),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  var id_ship = "";
  var addressOder = "";
  var itemsOder = [];
  var timeOderNow;
  var indexRemove = [];
  var timeBookManyDays = "";
  var timeFormTo = [];
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _submitForm() {
    final FormState form = myFormKey.currentState;
    timeBookManyDays = myDateRange.toString();
    form.save();
    order();
  }

  Future<void> order() {
    print("myDateRange");
    print(myDateRange);
    itemsOder = [];
    indexRemove = [];
    if (timeOder == null) {
      timeOderNow = now.toString().substring(0, 19);
    } else {
      timeOderNow = timeOder;
    }
    if (addressEdit == null) {
      addressOder = widget.dataUser['address'] +
          "," +
          widget.dataUser['Ward'] +
          "," +
          widget.dataUser['district'] +
          "," +
          widget.dataUser['city'];
    } else {
      addressOder = addressEdit;
    }
    if (widget.dataUser['city'] == 'Hưng Yên') {
      id_ship = "1";
    }
    if (widget.dataUser['city'] == 'Hà Nội') {
      id_ship = "2";
    }
    for (var i = 0; i < historyOder.length; i++) {
      if (historyOder[i]['active'] == true) {
        itemsOder.add(historyOder[i]);
      }
    }
    print("itemsOder");
    print(itemsOder);

    print(indexRemove);
    var day = timeOderNow.toString().substring(0, 9);
    var time = timeOderNow.toString().substring(10, 19);
    var code = day.replaceAll("-", "") +
        time.replaceAll(":", "").replaceAll(" ", "") +
        widget.dataUser['phoneNumber'].toString().substring(6, 9);
    if (itemsOder.length != 0) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(widget.dataUser['phoneNumber'])
          .collection("datas")
          .doc()
          .set({
            "time_from": myDateRange == null
                ? ""
                : myDateRange.toString().substring(0, 10),
            "time_to": myDateRange == null
                ? ""
                : myDateRange.toString().substring(26, 36),
            "time_book_many_days": myDateRange == null ? 0 : 1,
            "id_ship": id_ship,
            'time_oder': timeOderNow,
            'full_name': widget.dataUser['full_name'],
            'address': addressOder,
            'phoneNumber': widget.dataUser['phoneNumber'],
            'price': sumPrice * 1,
            'allPriceService': allPriceService * 1,
            'paymentType': paymentType,
            'items_oder': itemsOder,
            'status': 0,
            'service_code': code * 1
          })
          .then((value) => Toast.show("Đặt món thành công", context,
              textColor: Colors.red,
              backgroundColor: Colors.grey[400],
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.TOP))
          .catchError((error) => Toast.show("Đặt món thành công", context,
              textColor: Colors.red,
              backgroundColor: Colors.grey[400],
              duration: Toast.LENGTH_SHORT,
              gravity: Toast.TOP));
    } else {
      Toast.show("Bạn chưa chọn món nào", context,
          textColor: Colors.red,
          backgroundColor: Colors.grey[400],
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.TOP);
    }
  }
}
