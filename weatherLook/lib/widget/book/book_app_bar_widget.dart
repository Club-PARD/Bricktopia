// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_summary/pages/home_page.dart';

class BookAppBarWidget extends StatefulWidget {
  final String id;

  const BookAppBarWidget({
    super.key,
    required this.id,
  });

  @override
  State<BookAppBarWidget> createState() => _BookAppBarWidgetState();
}

class _BookAppBarWidgetState extends State<BookAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('${widget.id}_latitude');
            await prefs.remove('${widget.id}_longitude');
            await prefs.remove('${widget.id}_city');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: Image.asset("assets/Mask group.png"),
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}
