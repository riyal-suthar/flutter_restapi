// import 'package:flutter/material.dart';
//
// //This is the red badge on the message tab
// class Badge extends StatelessWidget {
//   final int number;
//   const Badge({
//     super.key,
//     required this.number,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(
//         color: Colors.red,
//         borderRadius: BorderRadius.circular(9),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(4, 4),
//             blurRadius: 5,
//             color: Colors.black.withOpacity(0.2),
//           ),
//         ],
//       ),
//       child: Text(number.toString(),
//           style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               )),
//     );
//   }
// }
