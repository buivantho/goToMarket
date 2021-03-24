import 'dart:convert';

import 'package:HouseCleaning/Home/NavigationHomeScreen.dart';
import 'package:HouseCleaning/model/todo.dart';
import 'package:HouseCleaning/repository/repository_service_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart';
import 'InputDeco_design.dart';

class FormPage extends StatefulWidget {
  final String phoneNumber;

  FormPage({@required this.phoneNumber});
  @override
  _FormPageState createState() => _FormPageState(phoneNumber);
}

List nameDistrict = [];
var dataDistrict;
var dataWard;
enum SingingCharacter { lafayette, jefferson }
String sexValue = 'Nam';
List data;
List datas;
bool _status = true;
String value = 'flutter';
var datePicker;
List<String> tags = [];
String _dropDownValue;
String _dropDownValueDistrict;
String _dropDownValueWard;
CollectionReference users = FirebaseFirestore.instance.collection('users');
final _formKey = GlobalKey<FormState>();
Future<List<Todo>> future;
String name;
int id;

class _FormPageState extends State<FormPage> {
  var phoneNumber;
  _FormPageState(this.phoneNumber);
  // String name, email, phone, address;
  final fullName = TextEditingController();
  final address = TextEditingController();
  Future<void> addUser() {
    // print(phoneNumber.toString());
    // print(sexValue);
    // print(fullName.text);
    // print(datePicker.toString().replaceAll("00:00:00.000", ''));
    // print(_dropDownValue);
    // print(_dropDownValueDistrict);
    // print(_dropDownValueWard);
    // print(address.text);
    createTodo(phoneNumber.toString());
    return users
        .doc(phoneNumber.toString())
        .set({
          'full_name': fullName.text,
          'birthday': datePicker.toString().replaceAll("00:00:00.000", ''),
          'sex': sexValue,
          'city': _dropDownValue,
          'district': _dropDownValueDistrict,
          'Ward': _dropDownValueWard,
          'address': address.text,
          'phoneNumber': phoneNumber.toString(),
        })
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainPage(
                      phoneNumber: phoneNumber.toString().startsWith("0")
                          ? phoneNumber.substring(1)
                          : phoneNumber)),
            ))
        .catchError((error) => print("Failed to add user: $error"));
  }

  List datacity = [];
  List s;
  var jsonResponse;
  Future<String> _makeGetRequest() async {
    // tạo GET request
    String url = 'https://thongtindoanhnghiep.co/api/city';
    Response response = await get(url);
    // data sample trả về trong response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    if (statusCode == 200) {
      setState(() {
        jsonResponse = json.decode(response.body);
        s = jsonResponse['LtsItem'];
        for (var i = 0; i < s.length; i++) {
          datacity.addAll({s[i]['Title']});
        }
      });
    }
    // https://thongtindoanhnghiep.co/api/city/4/district
  }

  final _formKey = GlobalKey<FormState>();
  Future<List<Todo>> future;
  String name;
  int id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _makeGetRequest();
    future = RepositoryServiceTodo.getAllTodos();
    // print(s.length);
  }

  void readData() async {
    final todo = await RepositoryServiceTodo.getTodo(id);
    print(todo.name);
  }

  updateTodo(Todo todo) async {
    todo.name = 'please 🤫';
    await RepositoryServiceTodo.updateTodo(todo);
    setState(() {
      future = RepositoryServiceTodo.getAllTodos();
    });
  }

  deleteTodo(Todo todo) async {
    await RepositoryServiceTodo.deleteTodo(todo);
    setState(() {
      id = null;
      future = RepositoryServiceTodo.getAllTodos();
    });
  }

  Card buildItem(Todo todo) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'name: ${todo.name}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () => updateTodo(todo),
                  child: Text('Update todo',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                FlatButton(
                  onPressed: () => deleteTodo(todo),
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'name',
        fillColor: Colors.grey[300],
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  void createTodo(phone) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      int count = await RepositoryServiceTodo.todosCount();
      final todo = Todo(count, phone, false);
      await RepositoryServiceTodo.addTodo(todo);
      setState(() {
        id = todo.id;
        future = RepositoryServiceTodo.getAllTodos();
      });
      print(todo.id);
    }
  }

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  SingingCharacter _character = SingingCharacter.lafayette;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _singleValue = "Text alignment right";
  int _stackIndex = 0;

  // String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Nam";

  List<String> _status = ["Nam", "Nữ", "Khác"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   radius: 70,
                //   child: Image.network(
                //       "https://protocoderspoint.com/wp-content/uploads/2020/10/PROTO-CODERS-POINT-LOGO-water-mark-.png"),
                // ),
                Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                        child: Image.asset(
                          'images/girl.jpg',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: fullName,
                    decoration: buildInputDecoration(Icons.person, "Họ & Tên"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Bạn chưa nhập họ tên';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      fullName.text = value;
                    },
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                    child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 1.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.blue, spreadRadius: 2),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 17.0),
                              child: Icon(
                                FontAwesomeIcons.birthdayCake,
                                size: 19.0,
                                color: Colors.grey[400],
                              ),
                            ),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: _verticalGroupValue,
                              onChanged: (value) => setState(() {
                                _verticalGroupValue = value;
                              }),
                              items: _status,
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    // decoration: ,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 2),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(color: Colors.blue, width: 0.5))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                // minTime: DateTime(2018, 3, 5),
                                // maxTime: DateTime(),
                                theme: DatePickerTheme(
                                    headerColor: Colors.orange,
                                    backgroundColor: Colors.blue,
                                    itemStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16)), onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours.toString());
                            }, onConfirm: (date) {
                              setState(() {
                                datePicker = date;
                                print('confirm $date');
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: datePicker == null
                              ? Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.birthdayCake,
                                      size: 17.0,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7.0, left: 10.0),
                                      child: Text(
                                        'Ngày sinh',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.birthdayCake,
                                      size: 17.0,
                                      color: Colors.grey[400],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7.0, left: 10.0),
                                      child: Text(
                                        '$datePicker'
                                            .toString()
                                            .replaceAll("00:00:00.000", ''),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    // decoration: ,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 2),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(color: Colors.blue, width: 0.5))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: DropdownButton(
                        hint: _dropDownValue == null
                            ? Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Thành phố',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      _dropDownValue,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                        items: datacity.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val;
                              _getDistrict(val);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    // decoration: ,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 2),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(color: Colors.blue, width: 0.5))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: DropdownButton(
                        hint: _dropDownValueDistrict == null
                            ? Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Quận huyện',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      _dropDownValueDistrict,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                        items: nameDistrict.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValueDistrict = val;
                              _getWard(val);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Container(
                    // decoration: ,
                    height: 60,
                    width: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.blue, spreadRadius: 2),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(color: Colors.blue, width: 0.5))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: DropdownButton(
                        hint: _dropDownValueWard == null
                            ? Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      'Phường xã',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.birthdayCake,
                                    size: 17.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      _dropDownValueWard,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                        items: nameWard.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValueWard = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:
                        buildInputDecoration(Icons.person, "Dịa chỉ giao hàng"),
                    controller: address,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Bạn chưa nhập địa chỉ chi tiết';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      address.text = value;
                    },
                  ),
                ),
                // ListView(
                //   padding: EdgeInsets.all(8),
                //   children: <Widget>[
                //     Form(
                //       key: _formKey,
                //       child: buildTextFormField(),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: <Widget>[
                //         // RaisedButton(
                //         //   onPressed: createTodo,
                //         //   child: Text('Create',
                //         //       style: TextStyle(color: Colors.white)),
                //         //   color: Colors.green,
                //         // ),
                //         RaisedButton(
                //           onPressed: id != null ? readData : null,
                //           child: Text('Read',
                //               style: TextStyle(color: Colors.white)),
                //           color: Colors.blue,
                //         ),
                //       ],
                //     ),
                //     FutureBuilder<List<Todo>>(
                //       future: future,
                //       builder: (context, snapshot) {
                //         if (snapshot.hasData) {
                //           return Column(
                //               children: snapshot.data
                //                   .map((todo) => buildItem(todo))
                //                   .toList());
                //         } else {
                //           return SizedBox();
                //         }
                //       },
                //     )
                //   ],
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                //   child: TextFormField(
                //     controller: password,
                //     keyboardType: TextInputType.text,
                //     decoration: buildInputDecoration(Icons.lock, "Password"),
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return 'Please a Enter Password';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding:
                //       const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                //   child: TextFormField(
                //     controller: confirmpassword,
                //     obscureText: true,
                //     keyboardType: TextInputType.text,
                //     decoration:
                //         buildInputDecoration(Icons.lock, "Confirm Password"),
                //     validator: (String value) {
                //       if (value.isEmpty) {
                //         return 'Please re-enter password';
                //       }
                //       print(password.text);

                //       print(confirmpassword.text);

                //       if (password.text != confirmpassword.text) {
                //         return "Password does not match";
                //       }

                //       return null;
                //     },
                //   ),
                // ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        print("successful");
                        setState(() {
                          addUser();
                        });
                        // addUser();
                        return;
                      } else {
                        print("UnSuccessfull");
                        addUser();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.blue, width: 2)),
                    textColor: Colors.white,
                    child: Text("Submit"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var idGetdistrict;
  void _getDistrict(city) {
    setState(() {
      for (var i = 0; i < s.length; i++) {
        if (city == s[i]['Title']) {
          idGetdistrict = s[i]['ID'];
        }
      }
      _makeGetRequestDistrict(idGetdistrict);
    });
  }

  Future<String> _makeGetRequestDistrict(idDistrict) async {
    nameDistrict = [];
    // tạo GET request
    String url = 'https://thongtindoanhnghiep.co/api/city/' +
        idGetdistrict.toString() +
        "/district";
    Response response = await get(url);
    // data sample trả về trong response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    if (statusCode == 200) {
      setState(() {
        dataDistrict = json.decode(response.body);
        print(dataDistrict);
        // s = jsonResponse['LtsItem'];
        for (var i = 0; i < dataDistrict.length; i++) {
          nameDistrict.addAll({dataDistrict[i]['Title']});

          // print(dataDistrict[i]['Title']);
        }
      });
    }
    // https://thongtindoanhnghiep.co/api/city/4/district
  }

  var idGetWard;
  void _getWard(district) {
    print(district);
    setState(() {
      for (var i = 0; i < dataDistrict.length; i++) {
        if (district == dataDistrict[i]['Title']) {
          idGetWard = dataDistrict[i]['ID'];
        }
      }

      // print(idGetWard);
      _makeGetRequestWard(idGetWard);
    });
  }

  List nameWard = [];
  Future<String> _makeGetRequestWard(idGetWard) async {
    nameWard = [];
    print(idGetWard);
    // tạo GET request
    String url = 'https://thongtindoanhnghiep.co/api/district/' +
        idGetWard.toString() +
        "/ward";
    Response response = await get(url);

    // data sample trả về trong response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    if (statusCode == 200) {
      setState(() {
        dataWard = json.decode(response.body);
        print(dataWard.length);
        for (var k = 0; k < dataWard.length; k++) {
          print(dataWard[k]['Title']);
          nameWard.addAll({dataWard[k]['Title']});
          print(nameWard);
        }
      });
    }

    // https://thongtindoanhnghiep.co/api/city/4/district
  }
}
