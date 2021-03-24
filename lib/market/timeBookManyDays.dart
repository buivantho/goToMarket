import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'marketPage.dart';
import 'oderBookManyDays.dart';

class TimeBookManyDays extends StatefulWidget {
  var dataUser;

  TimeBookManyDays({@required this.dataUser});
  @override
  _TimeBookManyDaysState createState() => _TimeBookManyDaysState();
}

CalendarController _controller;
var dataMarket = [];
var timedays = DateTime.now();
var timedayCv;
var dataUser;
Icon actionIcon = new Icon(Icons.save_alt_outlined);

class _TimeBookManyDaysState extends State<TimeBookManyDays> {
  @override
  void initState() {
    super.initState();
    timedayCv = "";
    dataMarket = [];
    timedayCv = timedays.toString().substring(0, 10);
    _controller = CalendarController();
    print(widget.dataUser);
    getData();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void getData() {
    print("timedayCvreplaceAll");
    print(timedayCv);
    dataMarket = [];
    FirebaseFirestore.instance
        .collection('addToBasketBookDays')
        .doc(widget.dataUser['phoneNumber'])
        .collection('datas')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc.data());
                if (doc.data()['timedays'] == timedayCv.replaceAll("-", "") &&
                    timedayCv == doc.data()['timebook']) {
                  setState(() {
                    dataMarket.add(doc.data());
                  });
                }
              })
            });
  }

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
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OderBookManyDays(
                                dataUser: widget.dataUser,
                              )));
                });
              },
            ),
          ]),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 370,
              child: TableCalendar(
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                    todayColor: Colors.red,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (day, events, holidays) {
                  setState(() {
                    timedays = day;
                    timedayCv = timedays.toString().substring(0, 10);
                    print(timedayCv);
                    getData();
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 10,
                height: 28.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(timedayCv.replaceAll("-", ""));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketPage(
                                dataUser: widget.dataUser,
                                databook: timedayCv.replaceAll("-", ""),
                                timebook: timedayCv,
                              ),
                            ));
                      },
                      child: Container(
                        width: 150.0,
                        height: 28.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text(
                            'Thêm món',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          border: Border.all(
                            color: Colors.red,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 10,
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: dataMarket == null ? 0 : dataMarket.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/loadingss.png",
                          // dataMarket[index]['image'],
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
                              dataMarket[index]['name_maker'].toString(),
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                            ),
                            // _buildRatingStars(dataMarket[index]["star"]),
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
                                  dataMarket[index]['qty'].toString(),
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
                                  FontAwesomeIcons.moneyBillWave,
                                  size: 10.0,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  dataMarket[index]['price'].toString() + "Đ",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.0,
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
                                  dataMarket[index]['timebook'].toString(),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
