// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_summary/pages/home_page.dart';

class AddAppBarWidget extends StatefulWidget {
  final double? longitude;
  final double? latitude;
  final String id;
  final String localName;

  const AddAppBarWidget({
    super.key,
    this.longitude,
    this.latitude,
    required this.id,
    required this.localName,
  });

  @override
  State<AddAppBarWidget> createState() => _AddAppBarWidgetState();
}

class _AddAppBarWidgetState extends State<AddAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 앱바 역할
      height: (MediaQuery.of(context).size.height) / 10.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // 아이콘들을 아래로 정렬
        crossAxisAlignment: CrossAxisAlignment.end,
        // 아이콘들을 오른쪽으로 정렬
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              ),
              const SizedBox(
                width: 235,
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setDouble(
                      '${widget.id}_latitude', widget.latitude!);
                  await prefs.setDouble(
                      '${widget.id}_longitude', widget.longitude!);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text(
                  "추가",
                  style: TextStyle(
                    color: Color(0xff5772D3),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
