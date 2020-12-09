import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class CleaningHourPage extends StatefulWidget {
  @override
  _CleaningHourPageState createState() => _CleaningHourPageState();
}

class _CleaningHourPageState extends State<CleaningHourPage> {
  List data;
  int count = 0;
  Future<String> _makeGetRequest() async {
    // tạo GET request
    String url = 'https://arcane-scrubland-56010.herokuapp.com/';
    Response response = await get(url);
    // data sample trả về trong response
    int statusCode = response.statusCode;
    print(statusCode);
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    this.setState(() {
      data = json.decode(response.body);
      count = data.length;
      print(count);
    });
    // Thực hiện convert json to object...
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
  
  @override
  void initState() {
    this._makeGetRequest();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => timerLoading());
  }
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
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
                  data.removeAt(index);
                });
              },
              key: ValueKey(data.elementAt(index)),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/tuvan.jpg',
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Họ & Tên: " + data[index]["name"],
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            "Chức vụ: " + data[index]["username"],
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            "Tuổi: " + data[index]["id"].toString(),
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            "Điện thoại: " + data[index]["address"]["zipcode"],
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
