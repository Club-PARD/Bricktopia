import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: (MediaQuery.of(context).size.height) / 10),
            Container(
              width: (MediaQuery.of(context).size.width) / 1.184,
              height: (MediaQuery.of(context).size.height) / 18.18,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffD9D5FC).withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffD9D5FC))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffD9D5FC))),
                  hintText: '지역 검색',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
