import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ByDate extends StatefulWidget {
  final String phoneNumber;

  ByDate({@required this.phoneNumber});
  @override
  _ByDateState createState() => _ByDateState(phoneNumber);
}

var id_user = "";
var service = [];
var indexService;
var objIdService = [];

class _ByDateState extends State<ByDate> {
  var phoneNumber;

  _ByDateState(this.phoneNumber);
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
                    .collection('oderBookMaryDays')
                    .doc(doc.id)
                    .collection('datas')
                    .get()
                    .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            setState(() {
                              if (doc.data()['id_ship'] == id_user.toString()) {
                                print(doc.data());
                                service.add(doc.data());
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
    service = [];
    objIdService = [];
    getDataUserShip();
    getData();
  }

  Widget build(BuildContext context) {
    print(service);
    return Scaffold(
      body: 
      ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
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
                                                                service[index][
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
                                                                  service[index]['items_oder']
                                                                              [
                                                                              i]
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
                                                                      [i]["qty"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.black,
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
                                                              color:
                                                                  Colors.black,
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
                                      Container(
                                        height: 40.0,
                                        width: 200.0,
                                        padding: EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            // setState(() {
                                            // deliveryStatus(service[index]
                                            //   ['phoneNumber']);
                                            //Navigator.of(context).pop();
                                            //});
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
                                                "xác nhận thu tiền",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Flexible(
                                      child: Text(
                                        "Địa chỉ: " + service[index]["address"],
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
        ],
      ),
    );
  }
}
