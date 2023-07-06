import 'package:flutter/material.dart';
import 'package:weather_summary/pages/setting.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) / 10.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width) / 18.95),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
                child: Image.asset(
                  'assets/icon/icon_settings.png',
                  width: (MediaQuery.of(context).size.width) / 13.5,
                ),
              ),
              SizedBox(width: (MediaQuery.of(context).size.width) / 17.23),
            ],
          ),
        ],
      ),
    );
  }
}
