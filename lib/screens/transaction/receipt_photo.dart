
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:steadypunpipi_vhack/models/report.dart';
// import 'package:steadypunpipi_vhack/screens/camera/report_analyse.dart';
// import 'package:steadypunpipi_vhack/services/api_service.dart';

// class ReceiptPhoto extends StatefulWidget {
//   String imgPath;

//   Photo({required this.imgPath, super.key});

//   @override
//   State<Photo> createState() => _PhotoState();
// }

// class _PhotoState extends State<Photo> {
//   final ApiService _apiService = ApiService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.chevron_left_rounded,
//               color: Colors.white,
//               size: 45,
//             )),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Expanded(
//               flex: 2,
//               child: Image.file(File(widget.imgPath), fit: BoxFit.cover),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 height: 120,
//                 color: Colors.black,
//                 child: Center(
//                   child: SizedBox(
//                     width: 70,
//                     height: 70,
//                     child: FloatingActionButton(
//                       child: Icon(
//                         Icons.check,
//                         size: 35,
//                         color: Colors.black,
//                       ),
//                       backgroundColor: Colors.white,
//                       shape: CircleBorder(),
//                       onPressed: () async {
//                         Report report =
//                             await _apiService.generateContent(widget.imgPath);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ReportAnalyse(imgPath: widget.imgPath, report: report,)));
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }