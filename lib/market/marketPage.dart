import 'dart:async';
import 'dart:convert';
import 'package:HouseCleaning/market/timeBookManyDays.dart';
import 'package:HouseCleaning/repository/repository_service_todo.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart';

import 'historyOder.dart';
import 'orderPage.dart';

class MarketPage extends StatefulWidget {
  var dataUser;
  var databook;
  var timebook;
  MarketPage({@required this.dataUser, this.databook, this.timebook});
  @override
  _MarketPageState createState() => _MarketPageState();
}

int _n;
var dataUser;
var databook;
var timebook;

class _MarketPageState extends State<MarketPage> {
  final List<String> imgList = [
    'https://chupanhmonan.com/wp-content/uploads/2018/10/chup-anh-mon-an-chuyen-nghiep-tu-liam-min-min.jpg',
    'https://www.chapter3d.com/wp-content/uploads/2020/06/anh-do-an.jpg',
    'https://azstudio.vn/wp-content/uploads/2020/03/CHU%CC%A3P-A%CC%89NH-SA%CC%89N-PHA%CC%82%CC%89M-13-1.jpg',
    'https://azstudio.vn/wp-content/uploads/2020/03/CHU%CC%A3P-A%CC%89NH-SA%CC%89N-PHA%CC%82%CC%89M-13-1.jpg',
    'https://azstudio.vn/wp-content/uploads/2020/03/CHU%CC%A3P-A%CC%89NH-SA%CC%89N-PHA%CC%82%CC%89M-13-1.jpg',
    'https://azstudio.vn/wp-content/uploads/2020/03/CHU%CC%A3P-A%CC%89NH-SA%CC%89N-PHA%CC%82%CC%89M-13-1.jpg'
  ];
  List dataSearch = [];
  List dataMarket = []; //laf chinhs
  List dataMaker = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getData() {
    FirebaseFirestore.instance
        .collection('maker')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                if (doc.data()['status'] == 0) {
                  dataMaker.add(doc.data());
                }
              })
            });
  }
  // SearchBar searchBar;

  bool loading = false;
  Timer timer;
  void timerLoading() {
    setState(() {
      loading = true;
      timer?.cancel();
      print(loading);
    });
  }

  List data;
  List datas;
  var text = "";
  var objsearch = [];
  @override
  void initState() {
    super.initState();
    print("databook.toString()");
    print(widget.databook);
    setState(() {
      dataSearch = dataMaker;
      dataMarket = dataSearch;
    });
    _n = 1;
    getData();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => timerLoading());
  }

  Widget appBarTitle = new Text("");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    print(dataMarket.length);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new GradientAppBar(
            leading: IconButton(
                icon: Icon(
                  FontAwesomeIcons.cartArrowDown,
                  color: Colors.white,
                  size: 20.0,
                ),
                onPressed: () => databook == null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryOder(
                                  dataUser: widget.dataUser,
                                )))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeBookManyDays(
                            dataUser: widget.dataUser,
                          ),
                        ))),
            centerTitle: true,
            title: appBarTitle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 164, 128, 1),
                  Color.fromRGBO(247, 114, 62, 1),
                ]),
            actions: <Widget>[
              new IconButton(
                icon: actionIcon,
                onPressed: () {
                  setState(() {
                    print(actionIcon);
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        onChanged: (string) {
                          setState(() {
                            dataMarket = dataSearch
                                .where((value) => (value['name_product']
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                                .toList();
                          });

                          // print(string);
                          // print(datas);
                        },
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: "Tìm kiếm đồ ăn",
                            hintStyle: new TextStyle(color: Colors.white)),
                      );
                    } else {
                      setState(() {
                        dataMarket = dataMaker;
                      });
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text("");
                    }
                  });
                },
              ),
            ]),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                child: CarouselSlider.builder(
              itemCount: imgList.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 4.0,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                      child: Image.network(
                    imgList[index],
                    fit: BoxFit.cover,
                    width: 1200,
                    height: 100,
                  )),
                );
              },
            )),
            SizedBox(
              height: 25.0,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: 500.0,
                    height: 100.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: listMarket == null ? 0 : listMarket.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   pushArrToList(listMarket[index]);
                          // });
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    listMarket[index]['img'],
                                    width: 50.0,
                                    height: 50.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  listMarket[index]['nameItem'],
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 35.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: objsearch == null ? 0 : objsearch.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          width: 110.0,
                          height: 15.0,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    objsearch[index]['nameItem'].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.white, width: 1)),
                                    child: GestureDetector(
                                      // onTap: () {
                                      //   setState(() {
                                      //     _deleteObjsearch(objsearch[index]);
                                      //     // print("123123");
                                      //   });
                                      // },
                                      child: Icon(
                                        FontAwesomeIcons.times,
                                        color: Colors.red,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          decoration: new BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(247, 114, 62, 1),
                                    Color.fromRGBO(255, 164, 128, 1),
                                  ]),
                              borderRadius: new BorderRadius.circular(20.0)),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 10,
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: dataMarket == null ? 0 : dataMarket.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: loading == false
                      ? Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 1.0,
                          child: Image.asset("assets/images/loading5.gif"),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              print(widget.dataUser);
                              print("dataUser");

                              // priceSumCount = dataMarket[index];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderPage(
                                            data: dataMarket[index],
                                            dataUser: widget.dataUser,
                                            databook: widget.databook,
                                            timebook: widget.timebook,
                                          )));
                            });
                            // print(dataMarket[index]['images'].length);
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                // "assets/images/loadingss.png",
                                dataMarket[index]['image'],
                                width: 130.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text(
                                    dataMarket[index]['name_product']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  _buildRatingStars(dataMarket[index]["star"]),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.sortAmountDown,
                                        size: 10.0,
                                        color: Colors.orange[900],
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Khuyến mại ",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      dataMarket[index]['sale_price'] == null
                                          ? Text(
                                              dataMarket[index]["sale_percent"]
                                                      .toString() +
                                                  "%",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          : Text(
                                              dataMarket[index]["sale_price"]
                                                      .toString() +
                                                  "Đ",
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                      Text(" Khi nhập ",
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w700)),
                                      Text(
                                        dataMarket[index]["name_sale"],
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.moneyBillWave,
                                        size: 10.0,
                                        color: Colors.yellow[600],
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        dataMarket[index]['price'].toString() +
                                            "Đ",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "/" + "1" + dataMarket[index]['unit'],
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.mapMarkedAlt,
                                        size: 10.0,
                                        color: Colors.green[600],
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        dataMarket[index]['address'],
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.mobileAlt,
                                        size: 10.0,
                                        color: Colors.purple[600],
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      Text(
                                        "+" +
                                            dataMarket[index]['phone']
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
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
                              //       size: 20.0,
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
            ),
          ],
        ));
  }

  Widget _buildAboutDialog(BuildContext context) {
    print(context);
  }

  List listMarket = [
    {
      "nameItem": "ĐỒ SỐNG",
      "id": 1,
      "active": 0,
      "img": "assets/images/dosong.jpg"
    },
    {
      "nameItem": "ĐỒ CHÍN",
      "id": 2,
      "active": 0,
      "img": "assets/images/dochin2.jpg"
    },
    {
      "nameItem": "RAU CỦ",
      "id": 3,
      "active": 0,
      "img": "assets/images/raucu.jpg"
    },
    {
      "nameItem": "HOA QUẢ",
      "id": 4,
      "active": 0,
      "img": "assets/images/hoaqua.jpg"
    },
    {
      "nameItem": "GIA VỊ",
      "id": 5,
      "active": 0,
      "img": "assets/images/giavi.jpg"
    },
    {
      "nameItem": "SET NẨU",
      "id": 6,
      "active": 0,
      "img": "assets/images/setlau.jpg"
    },
    {
      "nameItem": "SET CỖ",
      "id": 7,
      "active": 0,
      "img": "assets/images/mamco.jpg"
    },
  ];

  List objtest = [];
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(
      stars,
      style: TextStyle(fontSize: 10.0),
    );
  }

  double priceSumCount = 0.0;
  void add(price) {
    setState(() {
      _n++;
      priceSumCount = price * _n;
      print(priceSumCount);
    });
  }

  void minus(price) {
    setState(() {
      if (_n == 1) {
        priceSumCount = price;
      } else {
        _n--;
        priceSumCount = priceSumCount - price;
        print(priceSumCount);
      }
      ;
    });
  }
}
