import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/chat_model.dart';
import '../providers/chats_provider.dart';
import '../widgets/chat_item.dart';
import '../widgets/text_and_voice_field.dart';
import 'my_app_bar.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  void initState() {
    super.initState();
  }

/*
  void chatFirst() async {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(const ChatModel(
      id: "weady",
      message: "안녕하세요!"
          "\n저는 웨디 입니다!\n"
          "\n당신의 완벽한 하루를 위해"
          "\n같이 준비해봐요~\n"
          "\n궁금한게 있다면 \n"
          "무엇이든 물어보세요:)",
      isMe: false,
    ));
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final chats = ref.watch(chatsProvider).toList();
              return ListView.builder(
                reverse: false,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  if (chat.widget != null) {
                    return Column(
                      children: [
                        ChatItem(
                          text: chat.message,
                          isMe: chat.isMe,
                        ),
                        chat.widget!,
                      ],
                    );
                  } else {
                    return ChatItem(
                      text: chat.message,
                      isMe: chat.isMe,
                    );
                  }
                },
              );
            }),
          ),
          SlidingUpPanel(
            minHeight: 40,
            maxHeight: 205,
            color: const Color(0xffD9D9D9),
            panel: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 160, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade500,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 버튼 1 동작 처리
                        final chats = ref.read(chatsProvider.notifier);
                        chats.add(ChatModel(
                          id: DateTime.now().toString(),
                          message:
                              "원하는 지역을 입력해주세용:) \n <날씨>가 들어가게 입력 \nex) 포항 날씨",
                          isMe: false,
                        ));
                      },
                      child: const Text('원하는 지역의 날씨가?!😮'),
                    ),
                    const Divider(
                      color: Color(0xffF4F4F4),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 버튼 2 동작 처리
                        final chats = ref.read(chatsProvider.notifier);
                        chats.add(ChatModel(
                          id: DateTime.now().toString(),
                          message: '구체적으로 어떤 날인가요?! \n <성별&스타일&코디해줘>가 들어가게 입력',
                          isMe: false,
                        ));
                      },
                      child: const Text('특별한 오늘, 도대체 뭘 입어야?!😣'),
                    ),
                    const Divider(
                      color: Color(0xffF4F4F4),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 버튼 3 동작 처리
                        final chats = ref.read(chatsProvider.notifier);
                        chats.removeTypingWd();
                        chats.add(ChatModel(
                          id: DateTime.now().toString(),
                          message: '어디를 갈 때의 짐을 챙겨?!\n <물품 추천>이 들어가게 입력',
                          isMe: false,
                        ));
                      },
                      child: const Text('멀리가는데 짐 뭘 챙겨야?!🤔'),
                    ),
                  ],
                ),
              ),
            ),
            collapsed: Container(
              decoration:
                  BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
              child: const Center(
                child: Text(
                  "위로 올려주세요:)",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            borderRadius: radius,
          ),
          Container(
            color: Colors.black, // 검정색으로 변경
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextAndVoiceField(),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
