import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:toast/toast.dart';

class OderBookManyDays extends StatefulWidget {
  var dataUser;

  OderBookManyDays({@required this.dataUser});
  @override
  _OderBookManyDaysState createState() => _OderBookManyDaysState();
}

var dataUser;
var dataMarket = [];
var addressEdit;
var timeOder;
var index;
var indexPay;
int allPriceService;
int priceShip = 15000;
var paymentType = 'Tiền mặt';
Icon actionIcon = new Icon(Icons.save_alt_outlined);
int sumPrice = 0;

class _OderBookManyDaysState extends State<OderBookManyDays> {
  final address = TextEditingController();
  final timeText = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.dataUser);
    getData();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getData() {
    FirebaseFirestore.instance
        .collection('addToBasketBookDays')
        .doc(widget.dataUser['phoneNumber'])
        .collection('datas')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  dataMarket.add(doc.data());
                  print(dataMarket);
                });
              }),
              priceSum(dataMarket)
            });
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

  @override
  String dropdownValue = 'Tiền mặt';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Đặt món nhiều ngày'),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 164, 128, 1),
              Color.fromRGBO(247, 114, 62, 1),
            ]),
      ),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: Colors.white,
              child: DateTimePicker(
                controller: timeText,
                type: DateTimePickerType.time,

                icon: Icon(Icons.event),

                timeLabelText: "Hour",

                onChanged: (val) => timeOder = val,
                validator: (val) {
                  print(timeText);
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
                itemCount: dataMarket == null ? 0 : dataMarket.length,
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
                          print(dataMarket[index]);
                          // deleteItemOder(index);
                          dataMarket.removeAt(dataMarket[index]);
                        });
                      },
                      key: ValueKey(dataMarket.elementAt(index)),
                      child: Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 210,
                                        child: Text(
                                          "TÊN:" +
                                              dataMarket[index]["name_maker"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "GIÁ:" +
                                            dataMarket[index]["price"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 210,
                                        child: Text(
                                          "SL:: " +
                                              dataMarket[index]["qty"]
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        "TG:" +
                                            dataMarket[index]["timebook"]
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
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
  Future<void> order() {
    print(timeText.text);
    itemsOder = [];
    indexRemove = [];
    if (timeText.text == "") {
      Toast.show("Bạn chưa chọn giờ giao", context,
          textColor: Colors.red,
          backgroundColor: Colors.grey[400],
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.TOP);
    } else {
      var code = DateTime.now().toString().replaceAll("-", "").substring(0, 8) +
          widget.dataUser['phoneNumber'].toString().substring(6, 9);
      timeOderNow = timeText.text;
      print("123123");
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
      for (var i = 0; i < dataMarket.length; i++) {
        if (dataMarket[i]['active'] == true) {
          itemsOder.add(dataMarket[i]);
        }
      }
      print("itemsOder");
      print(itemsOder);

      print(indexRemove);

      widget.dataUser['phoneNumber'].toString().substring(6, 9);
      if (itemsOder.length != 0) {
        FirebaseFirestore.instance
            .collection('oderBookMaryDays')
            .doc(widget.dataUser['phoneNumber'])
            .collection("datas")
            .doc()
            .set({
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
    // print("123123");
  }
}
