import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:toast/toast.dart';

class OrderPage extends StatefulWidget {
  var data;
  var dataUser;
  var databook;
  var timebook;
  OrderPage({this.data, this.dataUser, this.databook, this.timebook});
  @override
  _OrderPageState createState() => _OrderPageState(data, dataUser);
}

class _OrderPageState extends State<OrderPage> {
  Timer _timer;
  var _weight = 0;
  int priceSumCount = 0;
  var data;
  var databook;
  var timebook;
  _OrderPageState(this.data, this.dataUser);
  @override
  var dataUser;
  void initState() {
    super.initState();
    print(widget.databook);
    _n = 0;
    add(data['price']);
    // dataMarket = liveFood;
    // this._makeGetRequest();
  }

  Widget build(BuildContext context) {
    print(data);
    print(dataUser);
    return Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back, color: Colors.black),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        // ),
        appBar: new GradientAppBar(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(255, 164, 128, 1),
                Color.fromRGBO(247, 114, 62, 1),
              ]),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
            child: ListView(
          children: [
            Container(
              child: new Swiper(
                itemBuilder: (BuildContext context, int indexs) {
                  return new Image.asset(
                    data['images'][indexs]['img'],
                    fit: BoxFit.cover,
                  );
                },
                itemCount: data['images'].length,
                itemWidth: MediaQuery.of(context).size.width * 0.95,
                itemHeight: MediaQuery.of(context).size.height * 0.40,
                viewportFraction: 0.8,
                scale: 0.9,
                layout: SwiperLayout.STACK,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['name_product'],
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    data['price'].toString() +
                        'Đ/' +
                        data['scales'].toString() +
                        data['unit'],
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 120.0, right: 120.0, top: 50.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: GestureDetector(
                          onTap: () {
                            add(data['price']);
                          },
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.green,
                            size: 25.0,
                          )),
                    ),
                    Text(
                      '$_n'.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: GestureDetector(
                          onTap: () {
                            minus(data['price']);
                          },
                          child: Icon(
                            FontAwesomeIcons.minus,
                            color: Colors.green,
                            size: 25.0,
                          )),
                    ),
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      print(widget.databook);
                      widget.databook == null ? oder() : oderBook();
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
                    width: 500.0,
                    height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _n.toString() + " Món",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            "Thêm vào giỏ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            priceSumCount.toString() + "Đ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        )));
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> oder() {
    print(_n);
    print(dataUser);
    print(data);
    print(dataUser['phoneNumber']);
    FirebaseFirestore.instance
        .collection("addToBasket")
        .doc(dataUser['phoneNumber'])
        .collection("datas")
        .doc()
        .set({
          'full_name': dataUser['full_name'],
          'address': dataUser['address'],
          'phoneNumber': dataUser['phoneNumber'],
          'unit_price': data['price'],
          'price': priceSumCount,
          'name_maker': data['name_product'],
          'qty': _n,
          'sex': dataUser['sex'],
          'id_product': 1,
          'status': 0,
          'active': true
        })
        .then((value) => Navigator.of(context).pop())
        .catchError((error) => print("Failed to add user: $error"));
    Toast.show("Đặt món thành công", context,
        textColor: Colors.red,
        backgroundColor: Colors.grey[400],
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.TOP);
  }

  Future<void> oderBook() {
    print(_n);
    print(dataUser);
    print(data);
    print(dataUser['phoneNumber']);
    FirebaseFirestore.instance
        .collection("addToBasketBookDays")
        .doc(dataUser['phoneNumber'])
        .collection("datas")
        .doc()
        .set({
          "timebook": widget.timebook,
          "timedays": widget.databook,
          'full_name': dataUser['full_name'],
          'address': dataUser['address'],
          'phoneNumber': dataUser['phoneNumber'],
          'unit_price': data['price'],
          'price': priceSumCount,
          'name_maker': data['name_product'],
          'qty': _n,
          'sex': dataUser['sex'],
          'id_product': 1,
          'status': 0,
          'active': true
        })
        .then((value) => Navigator.of(context).pop())
        .catchError((error) => print("Failed to add user: $error"));
    Toast.show("Đặt món thành công", context,
        textColor: Colors.red,
        backgroundColor: Colors.grey[400],
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.TOP);
  }

  int _n;
  void add(price) {
    setState(() {
      _n++;
      priceSumCount = price * _n;
      print(priceSumCount);
    });
  }

  void minus(price) {
    setState(() {
      // _n--;
      if (_n == 1) {
        priceSumCount = price;
      } else {
        _n--;
        priceSumCount = priceSumCount - price;
        print(priceSumCount);
      }
    });
  }
}
