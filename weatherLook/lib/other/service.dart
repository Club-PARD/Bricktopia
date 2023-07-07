import 'package:flutter/material.dart';

class servicePage extends StatefulWidget {
  const servicePage({super.key});

  @override
  State<servicePage> createState() => _servicePageState();
}

class _servicePageState extends State<servicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: (MediaQuery.of(context).size.height) / 9.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // 아이콘들을 아래로 정렬
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 오른쪽 정렬
                    children: [
                      SizedBox(width: (MediaQuery.of(context).size.width) / 14),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'icon/icon_back.png',
                          width: (MediaQuery.of(context).size.width) / 15.8,
                        ),
                      ),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width) / 21.4),
                      const Text('고객센터',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              )),
          SizedBox(height: (MediaQuery.of(context).size.height) / 10),
          Row(
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width) / 10),
              Text(
                '자세한 문의는\n\n인스타그램 weatherlook.official\n문의 부탁드립니다.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    );
  }
}
