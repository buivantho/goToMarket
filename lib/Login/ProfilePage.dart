import 'dart:convert';
import 'package:HouseCleaning/Home/NavigationHomeScreen.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:direct_select/direct_select.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:smart_select/smart_select.dart';
import 'MySelectionItem.dart';

class ProfilePage extends StatefulWidget {
  final String phoneNumber;

  ProfilePage({@required this.phoneNumber});
  @override
  MapScreenState createState() => MapScreenState(phoneNumber);
}

FirebaseStorage firestore = FirebaseStorage.instance;
var jsonResponse;
List s;
List datacity = [];
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

// FirebaseFirestore firestore = FirebaseFirestore.instance;
// Future<void> addUser() {
//   return users
//       .doc('ABC123')
//       .set({'full_name': "Mary Jane", 'age': 18})
//       .then((value) => print("User Added"))
//       .catchError((error) => print("Failed to add user: $error"));
// }

class ExampleNumber {
  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };

  String get numberString {
    return (map.containsKey(number) ? map[number] : "unknown");
  }

  ExampleNumber(this.number);

  String toString() {
    return ("$number $numberString");
  }

  static List<ExampleNumber> get list {
    return (map.keys.map((num) {
      return (ExampleNumber(num));
    })).toList();
  }
}

bool asTabs = false;
String selectedValue;
String preselectedValue = "dolor sit";
ExampleNumber selectedNumber;
List<int> selectedItems = [];
final List<DropdownMenuItem> items = [];

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  // final TextEditingController _searchQuery = new TextEditingController();
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

  void initState() {
    // TODO: implement initState
    super.initState();
    _makeGetRequest();
    // print(s.length);
  }

  // void createRecord() async {
  //   await firestore
  //       .collection("books")
  //       .add({
  //         'title': 'Mastering Flutter',
  //         'description': 'Programming Guide for Dart'
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
  // CollectionReference users = FirebaseStorage.instance.collection('overviews');
  // Future<void> addUser() {
  //   return users
  //       .add({'full_name': "Mary Jane", 'age': 18})
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  int selectedIndex1 = 0;
  final elements1 = [
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];
  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  List<String> optionss = [
    'Món Italia',
    'Món Thái Lan',
    'Món Ấn Độ',
    'Món Nhật Bản',
    'Món Việt Nam',
    'Món Hàn Quốc',
    'Món Trung Quốc',
    'Món Tây Ban Nha',
    'Món Pháp',
    'Món Hy Lạp',
    'Món Bangladesh',
    'Món Philippines',
    'Món Pakistan',
    'Món Ukraine',
    'Món Mỹ',
    'Món Mexico',
  ];
  // var timeConver = [];
  SingingCharacter _character = SingingCharacter.lafayette;
  final fullName = TextEditingController();
  final address = TextEditingController();
  var phoneNumber;
  MapScreenState(this.phoneNumber);
  Future<void> addUser() {
    print(phoneNumber.toString());
    print(fullName.text);
    print(sexValue);

    print(datePicker.toString().replaceAll("00:00:00.000", ''));
    print(_dropDownValue);
    print(_dropDownValueDistrict);
    print(_dropDownValueWard);
    print(address);
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

  @override
  Widget build(BuildContext context) {
    // print(datacity);
    // print(_dropDownValue);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   height: 50,
                //   width: 50,
                //   child: Icon(
                //     Icons.arrow_back_ios,
                //     size: 24,
                //     color: Colors.black54,
                //   ),
                //   decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black54),
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Cập nhập thông tin cá nhân',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(height: 24, width: 24)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Stack(
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(150, 250, 250, 2),
                      Colors.black54
                    ])),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),

                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: new TextField(
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                      controller: fullName,
                      // controller: this._emailController,
                      decoration: new InputDecoration(
                        // hintText: "Enter your email",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                        hintText: "Họ & Tên",
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
                  // SizedBox(
                  //   width: 5.0,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          // decoration: ,
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white60, width: 0.5))),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.deepOrange[400],
                            ),
                            child: DropdownButton<String>(
                              value: sexValue,
                              // icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              // elevation: 16,

                              underline: Container(color: Colors.transparent),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                              // underline: Container(
                              //   height: 1,
                              //   color: Colors.deepPurpleAccent,
                              // ),
                              onChanged: (String newValue) {
                                setState(() {
                                  sexValue = newValue;
                                });
                              },

                              items: <String>[
                                'Nam',
                                'Nữ',
                                'Khác'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      value,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                      Container(
                        // decoration: ,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white60, width: 0.5))),
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
                                          color: Colors.white,
                                          fontSize: 16)), onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              }, onConfirm: (date) {
                                setState(() {
                                  datePicker = date;
                                  ;
                                  print('confirm $date');
                                });
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: datePicker == null
                                ? Text(
                                    'Ngày sinh',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    '$datePicker'
                                        .toString()
                                        .replaceAll("00:00:00.000", ''),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  )),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 5.0,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Text(
                                  'Thành phố',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  _dropDownValue,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
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
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: DropdownButton(
                          hint: _dropDownValueDistrict == null
                              ? Text(
                                  'Quận huyện',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  _dropDownValueDistrict,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
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
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: DropdownButton(
                          hint: _dropDownValueWard == null
                              ? Text(
                                  'Phường xã',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  _dropDownValueWard,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
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
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: new TextField(
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                          controller: address,
                          decoration: new InputDecoration(
                            // hintText: "Enter your email",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                            hintText: "Địa chỉ chi tiết",
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
                    ],
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerLeft,
                // Container(
                //   width: MediaQuery.of(context).size.width * 1.0,
                //   height: 70.0,
                //   child: MultiSelectBottomSheetField(
                //     items: _animals
                //         .map((e) => MultiSelectItem(e, e.name))
                //         .toList(),
                //     listType: MultiSelectListType.CHIP,
                //     searchable: true,
                //     // decoration: BoxDecoration(...),
                //     onConfirm: (values) {
                //       setState(() {
                //         _selectedAnimals = values;
                //       });
                //     },
                //     chipDisplay: MultiSelectChipDisplay(),
                //   ),
                //   decoration: BoxDecoration(
                //       border: Border(
                //           bottom:
                //               BorderSide(color: Colors.white60, width: 0.5))),
                // ),
                SizedBox(
                  height: 160.0,
                ),
                // ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                //   child: Container(
                //     height: 60,
                //     child: DropdownButton(
                //       hint: _dropDownValue == null
                //           ? Text(
                //               'Thành phố',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.w600),
                //             )
                //           : Text(
                //               _dropDownValue,
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //       isExpanded: true,
                //       iconSize: 30.0,
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 18.0,
                //           fontWeight: FontWeight.w600),
                //       items: datacity.map(
                //         (val) {
                //           return DropdownMenuItem<String>(
                //             value: val,
                //             child: Text(val),
                //           );
                //         },
                //       ).toList(),
                //       onChanged: (val) {
                //         setState(
                //           () {
                //             _dropDownValue = val;
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                //   child: Container(
                //     height: 60,
                //     child: DropdownButton(
                //       hint: _dropDownValue == null
                //           ? Text(
                //               'Thành phố',
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.w600),
                //             )
                //           : Text(
                //               _dropDownValue,
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 18.0,
                //                   fontWeight: FontWeight.w600),
                //             ),
                //       isExpanded: true,
                //       iconSize: 30.0,
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 18.0,
                //           fontWeight: FontWeight.w600),
                //       items: datacity.map(
                //         (val) {
                //           return DropdownMenuItem<String>(
                //             value: val,
                //             child: Text(val),
                //           );
                //         },
                //       ).toList(),
                //       onChanged: (val) {
                //         setState(
                //           () {
                //             _dropDownValue = val;
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                //   child: Container(
                //     height: 60,
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Text(
                //           'Phone number',
                //           style: TextStyle(color: Colors.white70),
                //         ),
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(20)),
                //         border: Border.all(width: 1.0, color: Colors.white70)),
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 70,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              addUser();
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                "Xác nhận",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  // a simple usage

  List<int> value = [];
  List<S2Choice<int>> options = [
    S2Choice<int>(value: 1, title: 'Ionic'),
    S2Choice<int>(value: 2, title: 'Flutter'),
    S2Choice<int>(value: 3, title: 'React Native'),
  ];
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

// https://thongtindoanhnghiep.co/api/district/2/ward
}
