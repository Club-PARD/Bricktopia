// import 'package:flutter/material.dart';

// class personalizedPage extends StatefulWidget {
//   const personalizedPage({super.key});

//   @override
//   State<personalizedPage> createState() => _personalizedPageState();
// }

// class _personalizedPageState extends State<personalizedPage> {
//   @override
//   build(BuildContext context) {
//     int selectedValue;

//     return Scaffold(
//         body: Column(children: [
//       SizedBox(
//           height: (MediaQuery.of(context).size.height) / 10.8,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end, // 아이콘들을 아래로 정렬
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start, // 오른쪽 정렬
//                 children: [
//                   SizedBox(width: (MediaQuery.of(context).size.width) / 14),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Image.asset(
//                       'icon/icon_back.png',
//                       width: (MediaQuery.of(context).size.width) / 15.8,
//                     ),
//                   ),
//                   SizedBox(width: (MediaQuery.of(context).size.width) / 21.4),
//                   const Text('개인 맞춤 설정',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
//                 ],
//               ),
//             ],
//           )),
//       SizedBox(
//         height: (MediaQuery.of(context).size.height) / 9,
//       ),
//       const Text(
//         '온도 민감도 설정',
//         style: TextStyle(
//             fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//       SizedBox(height: (MediaQuery.of(context).size.height) / 26),
//       const Text(
//         '더욱 정확한 추천 서비스를 위해\n온도에 민감한 정도를 설정해 주세요',
//         style: TextStyle(fontSize: 16, color: Color(0xff4E5FFF)),
//         textAlign: TextAlign.center,
//       ),
//       SizedBox(height: (MediaQuery.of(context).size.height) / 10),
//       Row(
//         children: [
//           SizedBox(width: (MediaQuery.of(context).size.width) / 7.7),
//           const Text('추위를 타는 정도',
//               // textAlign: TextAlign.start,
//               style: TextStyle(fontSize: 16, color: Colors.black)),
//         ],
//       ),
//       SizedBox(height: (MediaQuery.of(context).size.height) / 22.22),
//       const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleButton(),
//         ],
//       ),
//     ]));
//   }
// }

// class CircleButton extends StatefulWidget {
//   const CircleButton({super.key});

//   @override
//   _CircleButtonState createState() => _CircleButtonState();
// }

// class _CircleButtonState extends State<CircleButton> {
//   int selectedValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     selectedValue = 1; // 초기 선택 값
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List.generate(5, (index) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedValue = index + 1;
//             });
//           },
//           child: Container(
//             width: 24.0,
//             height: 24.0,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: selectedValue == index + 1 ? Colors.blue : Colors.grey,
//             ),
//           ),
//         );
//       })
//           .expand((button) => [
//                 button,
//                 const SizedBox(width: 16.0), // 버튼 사이의 간격 조정
//               ])
//           .toList(),
//     );
//   }
// }
