import 'package:flutter/material.dart';

class personalResetPwdPage extends StatefulWidget {
  const personalResetPwdPage({super.key});

  @override
  State<personalResetPwdPage> createState() => _personalResetPwdPageState();
}

class _personalResetPwdPageState extends State<personalResetPwdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: (MediaQuery.of(context).size.height) / 10.8,
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
                      const Text('개인정보',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: (MediaQuery.of(context).size.height) / 10.8,
          ),
          Row(
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width) / 7.7),
              const Text('이메일',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, color: Color(0xff4E5FFF))),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 40),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 1.353,
            height: 48,
            child: TextField(
              // controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'weather.look@gmail.com',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  hintStyle:
                      const TextStyle(fontSize: 16, color: Color(0xff9E9E9E)),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70.0),
                  )),
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 20),
          Row(
            children: [
              SizedBox(width: (MediaQuery.of(context).size.width) / 7.7),
              const Text('비밀번호',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, color: Color(0xff4E5FFF))),
            ],
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 40),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 1.353,
            height: 48,
            child: TextField(
              // controller: _passwordController,
              decoration: InputDecoration(
                  hintText: '●●●●●●●●',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  hintStyle:
                      const TextStyle(fontSize: 16, color: Color(0xff9E9E9E)),
                  filled: true,
                  fillColor: const Color(0xffe8E8E8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70.0),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 40),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 1.353,
            height: 48,
            child: TextField(
              // controller: _passwordController,
              decoration: InputDecoration(
                  hintText: '새 비밀번호',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  hintStyle:
                      const TextStyle(fontSize: 16, color: Color(0xff9E9E9E)),
                  filled: true,
                  fillColor: const Color(0xffe8E8E8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70.0),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 43),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 1.353,
            height: 48,
            child: TextField(
              // controller: _passwordController,
              decoration: InputDecoration(
                  hintText: '새 비밀번호 확인',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  hintStyle:
                      const TextStyle(fontSize: 16, color: Color(0xff9E9E9E)),
                  filled: true,
                  fillColor: const Color(0xfff4f4f4),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70.0),
                      borderSide: BorderSide.none)),
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 20),
          SizedBox(
            width: (MediaQuery.of(context).size.width) / 2.7,
            height: (MediaQuery.of(context).size.height) / 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4e5fff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  )),
              onPressed: () {
                Navigator.pushNamed(context, '/personalResetPwd');
              },
              child: const Text(
                "비밀번호 변경하기",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).size.height) / 6),
          TextButton(
              onPressed: () {},
              child: const Text('계정 삭제',
                  style: TextStyle(fontSize: 14, color: Color(0xff9E9E9E))))
        ],
      ),
    );
  }
}
