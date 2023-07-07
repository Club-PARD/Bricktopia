import 'package:flutter/material.dart';
import 'package:weather_summary/pages/setting.dart';

class HomeAppBarWidget extends StatefulWidget {
  const HomeAppBarWidget({super.key});

  @override
  State<HomeAppBarWidget> createState() => _HomeAppBarWidgetState();
}

class _HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
                child: Image.asset(
                  'assets/icon/setting.png',
                  width: (MediaQuery.of(context).size.width) / 13.5,
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width) /10,
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
