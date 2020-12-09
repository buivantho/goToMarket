// import 'dart:async';

// import 'package:HouseCleaning/Home/HomePage.dart';
// import 'package:HouseCleaning/Home/HomePagev2.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   var type;
//   LoginPage({this.type});
//   @override
//   _LoginPageState createState() => _LoginPageState(type);
// }

// class _LoginPageState extends State<LoginPage> {
//   int type;
//   Timer timer;
//   Timer timerCondow;
//   _LoginPageState(this.type);
//   int statusRegistration = 0;
//   int statusLogin = 0;
//   bool loadingOTP = true;

//   void timerLoadingOTP() {
//     setState(() {
//       loadingOTP = false;
//       timer?.cancel();
//       print(loadingOTP);
//     });
//   }

//   int i = 60;
//   void _btnLogin() {
//     timer =
//         Timer.periodic(Duration(seconds: 10), (Timer t) => timerLoadingOTP());
//     _btntimeCondow();
//   }

//   Timer timers;
//   void _btntimeCondow() {
//     // while (loadingOTP) {}
//     if (loadingOTP == true) {
//       timers =
//           Timer.periodic(Duration(seconds: 10), (Timer t) => _btntimeCondow());
//       i--;
//       print(i);
//     } else {
//       timers?.cancel();
//     }
//     // _btntimeCondow();
//   }

//   void _btnLoginHome() {}
//   @override
//   void initState() {
//     print(type);
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: ListView(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width * 10,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 left: 20,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 40.0,
//                     height: 40.0,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: Colors.grey),
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: GestureDetector(
//                         child: Stack(
//                           children: [
//                             Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                               size: 30,
//                             ),
//                           ],
//                         ),
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ClipRRect(
//               child: type == 1
//                   ? Image.asset(
//                       'assets/images/congtacvien.jpg',
//                       fit: BoxFit.fill,
//                     )
//                   : Image.asset(
//                       'assets/images/khachhang.jpg',
//                       fit: BoxFit.fill,
//                     )),
//           statusLogin == 1
//               ? TextFormField(
//                   decoration: new InputDecoration(
//                     labelText: "Nhập mã OTP",
//                     fillColor: Colors.white,
//                     border: new OutlineInputBorder(
//                       borderRadius: new BorderRadius.circular(25.0),
//                       borderSide: new BorderSide(),
//                     ),
//                     //fillColor: Colors.green
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       if (value.length == 6) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => HomePageV2()));
//                       }
//                     });
//                   },
//                 )
//               : TextFormField(
//                   decoration: new InputDecoration(
//                     labelText: "Số điện thoại",
//                     fillColor: Colors.white,
//                     border: new OutlineInputBorder(
//                       borderRadius: new BorderRadius.circular(25.0),
//                       borderSide: new BorderSide(),
//                     ),
//                     //fillColor: Colors.green
//                   ),
//                 ),
//           SizedBox(
//             height: 20.0,
//           ),
//           statusLogin == 1
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     loadingOTP == true
//                         ? GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 statusRegistration = 1;
//                               });
//                             },
//                             child: Text(
//                               "Thời gian gửi mã OTP",
//                               style: TextStyle(
//                                   fontSize: 20.0,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w600),
//                               textAlign: TextAlign.center,
//                             ),
//                           )
//                         : GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 statusRegistration = 1;
//                               });
//                             },
//                             child: Text(
//                               "Gửi lại mã OTP",
//                               style: TextStyle(
//                                   fontSize: 20.0,
//                                   color: Colors.blue[300],
//                                   fontWeight: FontWeight.w600),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           statusRegistration = 1;
//                         });
//                       },
//                       child: Text(
//                         "Quay lại ",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.blue[300],
//                             fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 )
//               : Column(
//                   children: [
//                     Container(
//                       width: 350.0,
//                       height: 50.0,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.blue,
//                         ),
//                         borderRadius: BorderRadius.circular(100.0),
//                       ),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               statusLogin = 1;
//                               _btnLogin();
//                             });
//                           },
//                           child: statusRegistration == 1
//                               ? Text(
//                                   "ĐĂNG KÝ",
//                                   style: TextStyle(fontSize: 25.0),
//                                   textAlign: TextAlign.center,
//                                 )
//                               : Text(
//                                   "ĐĂNG NHẬP",
//                                   style: TextStyle(fontSize: 25.0),
//                                   textAlign: TextAlign.center,
//                                 ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     Container(
//                       child: statusRegistration == 1
//                           ? GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   statusRegistration = 0;
//                                 });
//                               },
//                               child: Text(
//                                 "ĐÃ CÓ TÀI KHOẢN",
//                                 style: TextStyle(
//                                     fontSize: 20.0,
//                                     color: Colors.blue[300],
//                                     fontWeight: FontWeight.w600),
//                                 textAlign: TextAlign.center,
//                               ),
//                             )
//                           : GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   statusRegistration = 1;
//                                 });
//                               },
//                               child: type == 1
//                                   ? Text(
//                                       "Đăng ký khách hàng",
//                                       style: TextStyle(
//                                           fontSize: 20.0,
//                                           color: Colors.blue[300],
//                                           fontWeight: FontWeight.w600),
//                                       textAlign: TextAlign.center,
//                                     )
//                                   : Text(
//                                       "Đăng ký làm công tác viên",
//                                       style: TextStyle(
//                                           fontSize: 20.0,
//                                           color: Colors.blue[300],
//                                           fontWeight: FontWeight.w600),
//                                       textAlign: TextAlign.center,
//                                     ),
//                             ),
//                     )
//                   ],
//                 )
//         ],
//       ),
//     );
//   }
// }
