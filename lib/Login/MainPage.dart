// import 'package:flutter/material.dart';

// import 'LoginPage.dart';

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int type;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: MediaQuery.of(context).size.width * 10,
//         height: MediaQuery.of(context).size.height * 10,
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               child: Image.asset(
//                 'assets/images/bg.jpg',
//                 fit: BoxFit.fill,
//               ),
//             ),
//             SizedBox(
//               height: 100.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: 200.0,
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.blue,
//                     ),
//                     borderRadius: BorderRadius.circular(100.0),
//                   ),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage(
//                                       type: 0,
//                                     )));
//                       },
//                       child: Text(
//                         "CỘNG TÁC VIÊN",
//                         style: TextStyle(fontSize: 25.0),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 200.0,
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.blue,
//                     ),
//                     borderRadius: BorderRadius.circular(100.0),
//                   ),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage(
//                                       type: 1,
//                                     )));
//                       },
//                       child: Text(
//                         "KHÁCH HÀNG",
//                         style: TextStyle(fontSize: 25.0),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
