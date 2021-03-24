import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Statistical extends StatefulWidget {
  final String phoneNumber;

  Statistical({@required this.phoneNumber});
  @override
  _StatisticalState createState() => _StatisticalState(phoneNumber);
}

var id_user = "";
var service = [];
var indexService;
var objIdService = [];
var sumPrice = 0;
var sumPriceShip = 15000;
var orange = Color(0xFFfc9f6a);
var pink = Color(0xFFee528c);
var blue = Color(0xFF8bccd6);
var darkBlue = Color(0xFF60a0d7);
var valueBlue = Color(0xFF5fa0d6);

class _StatisticalState extends State<Statistical> {
  var phoneNumber;

  _StatisticalState(this.phoneNumber);
  void getDataUserShip() {
    print("1231231231");
    FirebaseFirestore.instance.collection('account').get().then(
        (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
              if (doc.data()['phone_login'] == phoneNumber.toString()) {
                // print(doc.data()['id_user_ship']);
                id_user = doc.data()['id_user_ship'];
              }
              // if (doc.data()['phone_login'] == "327966331") {
              //   // print(doc.data()['id_user_ship']);

              //   id_user = doc.data()['id_user_ship'];
              // }
            }));
  }

  void getData() {
    print("id_user.toString()");
    print(id_user.toString());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc.id);
                FirebaseFirestore.instance
                    .collection('products')
                    .doc(doc.id)
                    .collection('datas')
                    .get()
                    .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            setState(() {
                              if (doc.data()['id_ship'] == id_user.toString() &&
                                  doc.data()['status'] == 4 &&
                                  phoneNumber.toString() ==
                                      doc.data()['phoneUser_ship']) {
                                service.add(doc.data());
                                print(doc.data());
                                objIdService.add(doc.id);
                                sumPrice =
                                    sumPrice + doc.data()['allPriceService'];
                              }
                            });
                          }),
                        });
              }),
            });
  }

  @override
  void initState() {
    super.initState();
    sumPrice = 0;
    service = [];
    objIdService = [];
    getDataUserShip();
    getData();
    // sumPriceShip = sumPriceShip * service.length;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xFFf7f8fc),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Thống kê ',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Đơn hàng đã hoàn thành',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      service.length.toString(),
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
          ItemCard('Tổng số tiền', sumPrice.toString(), [orange, pink]),
          SizedBox(
            height: 8.0,
          ),
          ItemCard('Tổng số tiền nhận được',
              (sumPriceShip * service.length).toString(), [blue, darkBlue]),
          SizedBox(
            height: 32.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Đơn hàng',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 18.0),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: service == null ? 0 : service.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          indexService = index;
                        });
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 500.0,
                                          width: 300.0,
                                          child: ListView.builder(
                                            itemCount: service[index]
                                                        ['items_oder'] ==
                                                    null
                                                ? 0
                                                : service[index]['items_oder']
                                                    .length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Container(
                                                height: 100.0,
                                                width: 100.0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  service[index]
                                                                          [
                                                                          'items_oder'][i]
                                                                      [
                                                                      "name_maker"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Text(
                                                                "Giá" +
                                                                    service[index]['items_oder'][i]
                                                                            [
                                                                            "price"]
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            "Số lượng: " +
                                                                service[index][
                                                                            'items_oder']
                                                                        [
                                                                        i]["qty"]
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            "Ngày Giao: " +
                                                                service[index]['items_oder']
                                                                            [i][
                                                                        "timebook"]
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 90,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.orange)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 17.0),
                                  child: Text(
                                    service[index]['items_oder']
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mã đơn hàng: " +
                                          service[index]["service_code"],
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tên Khách hàng: " +
                                          service[index]["full_name"],
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Số điện thoại: " +
                                          "0" +
                                          service[index]["phoneNumber"],
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Số tiền thu: " +
                                          service[index]["allPriceService"]
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Thanh toán: " +
                                          service[index]["paymentType"],
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Flexible(
                                        child: Text(
                                          "Địa chỉ: " +
                                              service[index]["address"],
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class ValueCard extends StatelessWidget {
  final name;
  final value;
  final date;
  final bank;
  ValueCard(this.name, this.value, this.date, this.bank);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6)),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: valueBlue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  bank,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            SizedBox(
              height: 4.0,
            ),
            Divider()
          ],
        ));
  }
}

class ItemCard extends StatelessWidget {
  final titel;
  final value;
  final colors;
  ItemCard(this.titel, this.value, this.colors);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: colors),
            borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titel,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
