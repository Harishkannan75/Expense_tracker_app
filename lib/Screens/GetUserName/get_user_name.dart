// import 'package:flutter/material.dart';

// class Getusername extends StatelessWidget {
//   const Getusername({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     TextEditingController userNamecontroller = TextEditingController();
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       insetPadding: EdgeInsets.all(20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Form(
//           child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: height * 0.01,
//             ),
//             const Text(
//               "User Detail",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//               textAlign: TextAlign.left,
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             const Padding(
//               padding: EdgeInsets.only(left: 20),
//               child: SizedBox(
//                   width: double.infinity,
//                   child: Text(
//                     "User Name",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.left,
//                   )),
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 20, left: 20),
//               child: TextFormField(
//                 validator: (value) {
//                   if (value!.isEmpty)
//                     return 'Enter user name ';
//                   else
//                     return null;
//                 },
//                 controller: userNamecontroller,
//                 decoration: InputDecoration(
//                   contentPadding: const EdgeInsets.all(21.0),
//                   suffixIcon: const Padding(
//                     padding: EdgeInsets.all(0.0),
//                     child: Icon(
//                       Icons.person,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//             InkWell(
//               child: Container(
//                 height: height * 0.06,
//                 width: width * 0.50,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.green),
//                 child: const Center(
//                   child: Text(
//                     "Save",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: height * 0.02,
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
