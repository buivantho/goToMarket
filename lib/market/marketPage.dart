import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart';

class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

int _n;

class _MarketPageState extends State<MarketPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  // List data;
  // List datas;
  // // final TextEditingController _searchQuery = new TextEditingController();
  // Future<String> _makeGetRequest() async {
  //   // tạo GET request
  //   String url = 'https://jsonplaceholder.typicode.com/users';
  //   Response response = await get(url);
  //   // data sample trả về trong response
  //   int statusCode = response.statusCode;
  //   Map<String, String> headers = response.headers;
  //   String contentType = headers['content-type'];
  //   this.setState(() {
  //     data = json.decode(response.body);
  //     datas = data;
  //     print(data);
  //   });
  //   // Thực hiện convert json to object...
  // }

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
    print(objsearch);
    dataMarket = dataMarketss;
    print(data);
    _n = 1;
    // dataMarket = liveFood;
    // this._makeGetRequest();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => timerLoading());
  }

  Widget appBarTitle = new Text("");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    // print(dataMarket);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new GradientAppBar(
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
                            dataMarket = dataMarketss
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
                            hintText: "Tên sân bóng",
                            hintStyle: new TextStyle(color: Colors.white)),
                      );
                    } else {
                      setState(() {
                        dataMarket = dataMarketss;
                      });
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text("ĐẶT SÂN BÓNG");
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
                          setState(() {
                            pushArrToList(listMarket[index]);
                          });
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
                                      onTap: () {
                                        setState(() {
                                          _deleteObjsearch(objsearch[index]);
                                          // print("123123");
                                        });
                                      },
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
                              priceSumCount = dataMarket[index]['price'];
                            });
                            print(dataMarket[index]['images'].length);
                            showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,

                              // backgroundColor: Colo rs.grey[200],
                              builder: (BuildContext context) {
                                return Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                          colors: [
                                            Color.fromRGBO(255, 164, 128, 1),
                                            Color.fromRGBO(247, 114, 62, 1),
                                          ]),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.80,
                                    // color: Colors.amber,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                            child: new Swiper(
                                          itemBuilder: (BuildContext context,
                                              int indexs) {
                                            return new Image.asset(
                                              dataMarket[index]['images']
                                                  [indexs]['img'],
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          itemCount: dataMarket[index]['images']
                                              .length,
                                          itemWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.95,
                                          itemHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.40,
                                          viewportFraction: 0.8,
                                          scale: 0.9,
                                          layout: SwiperLayout.STACK,
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dataMarket[index]
                                                    ['name_product'],
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                dataMarket[index]['price']
                                                        .toString() +
                                                    'Đ/' +
                                                    dataMarket[index]['scales']
                                                        .toString() +
                                                    dataMarket[index]['unit'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 120.0,
                                                right: 120.0,
                                                top: 50.0,
                                                bottom: 50.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 35.0,
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100.0))),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        add(dataMarket[index]
                                                            ['price']);
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
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Container(
                                                  width: 35.0,
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  100.0))),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        minus(dataMarket[index]
                                                            ['price']);
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
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color.fromRGBO(
                                                            255, 164, 128, 1),
                                                        Color.fromRGBO(
                                                            247, 114, 62, 1),
                                                      ]),
                                                ),
                                                width: 500.0,
                                                height: 50.0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _n.toString() + " Món",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.0),
                                                      ),
                                                      Text(
                                                        "Thêm vào giỏ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.0),
                                                      ),
                                                      Text(
                                                        priceSumCount
                                                                .toString() +
                                                            "Đ",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ));
                              },
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
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
                                        "/" +
                                            dataMarket[index]['scales']
                                                .toString() +
                                            dataMarket[index]['unit'],
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
                                        dataMarket[index]['addres'],
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

  List dataLive = [
    {
      "id_product": 5,
      "id": 3,
      "name_product": "Thịt lợnssssssssssssss",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 5,
      "id": 1,
      "name_product": "Tôm",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 1,
      "id": 2,
      "name_product": "Cá rô",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 1,
      "id": 3,
      "name_product": "Gà ta",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332
    }
  ];

  List cookedFood = [
    {
      "id_product": 3,
      "id": 3,
      "name_product": "Gà rán",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 4,
      "id": 1,
      "name_product": "Gà",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/setlau.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 5,
      "id": 2,
      "name_product": "Cá",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/dochin.png",
      "phone": 8427966332
    },
  ];
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
  List testobj = [
    {
      "id_product": 3,
      "id": 1,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 1,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 2,
      "id": 3,
      "name_product": "Gà rán",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 1,
      "id": 1,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332
    },
    {
      "id_product": 3,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332
    },
  ];
  List dataMarket = [];
  List dataMarketss = [
    {
      "id_product": 3,
      "id": 1,
      "name_product": "Gà ránsssssssssssssssssss",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/raucu.jpg"},
        {"img": "assets/images/giavi.jpg"},
        {"img": "assets/images/setlau.jpg"},
        {"img": "assets/images/raucu.jpg"},
        {"img": "assets/images/mamco.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 2,
      "name_product": "Cá",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/raucu.jpg"},
        {"img": "assets/images/giavi.jpg"},
        {"img": "assets/images/setlau.jpg"},
      ]
    },
    {
      "id_product": 2,
      "id": 3,
      "name_product": "Gà rán",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 1,
      "name_product": "Thịt lợn",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 3,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 3,
      "id": 1,
      "name_product": "Cá chép",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 2,
      "id": 3,
      "name_product": "Gà rán",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 1,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 4,
      "id": 2,
      "name_product": "bi",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 3,
      "id": 1,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 5,
      "id": 3,
      "name_product": "Gà rán",
      "scales": 10,
      "unit": "KG",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 5,
      "price": 200.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/giavi.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 1,
      "id": 1,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 100,
      "unit": "G",
      "price": 100.000,
      "sale_percent": 50,
      "name_sale": "THODZ",
      "image": "assets/images/raucu.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
    },
    {
      "id_product": 6,
      "id": 2,
      "name_product": "Gà rán",
      "addres": "90 quán thánh , ba đình , hà nội",
      "star": 3,
      "scales": 1,
      "unit": "KG",
      "price": 500.000,
      "sale_price": 10.000,
      "name_sale": "THODZ",
      "image": "assets/images/hoaqua.jpg",
      "phone": 8427966332,
      "images": [
        {"img": "assets/images/giavi.jpg"},
      ]
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

  void pushArrToList(datalistMarket) {
    for (var i = 0; i < listMarket.length; i++) {
      if (datalistMarket['id'] == listMarket[i]['id']) {
        print(datalistMarket);
        objsearch = [];
        objsearch.add(datalistMarket);
      }
    }
    for (var j = 0; j < objsearch.length; j++) {
      if (objsearch[j]['id'] == 1) {
        print("1");
        dataMarket = dataMarketss
            .where((item) =>
                (item['id_product'].toString().contains(1.toString())))
            .toList();
      } else if (objsearch[j]['id'] == 2) {
        print("1");
        dataMarket = dataMarketss
            .where((item) =>
                (item['id_product'].toString().contains(2.toString())))
            .toList();
      } else if (objsearch[j]['id'] == 3) {
        print("1");
        dataMarket = dataMarketss
            .where((item) =>
                (item['id_product'].toString().contains(3.toString())))
            .toList();
      } else if (objsearch[j]['id'] == 4) {
        print("1");
        dataMarket = dataMarketss
            .where((item) =>
                (item['id_product'].toString().contains(4.toString())))
            .toList();
      } else if (objsearch[j]['id'] == 5) {
        print("1");
        dataMarket = dataMarketss
            .where((item) =>
                (item['id_product'].toString().contains(5.toString())))
            .toList();
      }
    }
  }

  void _deleteObjsearch(dataObj) {
    for (var i = 0; i < listMarket.length; i++) {
      if (dataObj['id'] == listMarket[i]['id']) {
        objsearch.remove(dataObj);
        if (listMarket[i]['active'] == 1) {
          listMarket[i]['active'] = 0;
        }
      }
    }
    dataMarket = dataMarketss
        .where(
            (item) => (item['id_product'].toString().contains("".toString())))
        .toList();
  }
}
