import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_summary/chatbot/widgets/todayWeather.dart';

import '../models/chat_model.dart';
import '../providers/chats_provider.dart';
import '../services/ai_handler.dart';
import '../services/voice_handler.dart';
import 'fivedayWeather.dart';
import 'toggle_button.dart';
import 'package:translator/translator.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  final AIHandler _openAI = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();
  final translator = GoogleTranslator();
  var _isReplying = false;
  var _isListening = false;

  @override
  void initState() {
    voiceHandler.initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                //
                controller: _messageController,
                onChanged: (value) {
                  value.isNotEmpty
                      ? setInputMode(InputMode.text)
                      : setInputMode(InputMode.voice);
                },
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE8E8E8),
                  hintText: '텍스트를 입력하세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    borderRadius: BorderRadius.circular(
                      35,
                    ),
                  ),
                ),
              ), // 입력란 꾸미기
            ),
            const SizedBox(
              width: 06,
            ),
            ToggleButton(
              isListening: _isListening,
              isReplying: _isReplying,
              inputMode: _inputMode,
              sendTextMessage: () async {
                final message = _messageController.text;
                _messageController.clear();

                if (message.contains("코디")) {
                  // "코디"가 포함된 경우에 수행할 동작을 여기에 작성합니다.
                  sendTextMessageCloth(message);
                  // 원하는 동작을 수행하도록 코드를 작성합니다.
                } else if (message.contains("물품 추천")) {
                  // "코디"가 포함되지 않은 경우에 수행할 동작을 여기에 작성합니다.
                  sendTextMessageBag(message);
                  // 원하는 동작을 수행하도록 코드를 작성합니다.
                } else if (message.contains("웨더룩")) {
                  // "코디"가 포함되지 않은 경우에 수행할 동작을 여기에 작성합니다.
                  final chats = ref.read(chatsProvider.notifier);
                  chats.add(ChatModel(
                    id: DateTime.now().toString(),
                    message: "브릭토피아: 함께 쌓아가는 빌더들\n"
                        "\n '브릭’의 견고함과 ‘토피아’에서 파생된 유토피아의 이상적인 사회를 합성한 브릭토피아는 “견고하고 창의적인 다양한 사람들이 모인 곳” 을 의미합니다.\n"
                        "\n저희는 브릭토피아의 \n👮‍♀(기획자/리더) 김민영,"
                        "\n🚍(디자이너)윤새은"
                        "\n🔘(개발자)구현우,정성국,심재인\n"
                        "\n이렇게 다섯이 모여 하나의 버스를 운영하고 있습니다!🚌",
                    isMe: false,
                  ));
                  // 원하는 동작을 수행하도록 코드를 작성합니다.
                } else if (message.contains("날씨")) {
                  // "코디"가 포함되지 않은 경우에 수행할 동작을 여기에 작성합니다.
                  String text = message;
                  List<String> parts = text.split(" ");
                  String cityName = parts[0];

                  var translation = await translator.translate(cityName,
                      from: 'ko', to: 'en');
                  String cityTrans = translation.toString();

                  sendTextMessageWeather(cityTrans);
                  // 원하는 동작을 수행하도록 코드를 작성합니다.
                } else {
                  sendTextMessageAI(message);
                }
              },
              sendVoiceMessage: sendVoiceMessage,
            )
          ],
        ),
      ],
    );
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() async {
    if (!voiceHandler.isEnabled) {
      print('Not supported');
      return;
    }
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningState(false);
    } else {
      setListeningState(true);
      final result = await voiceHandler.startListening();
      //print(result);
      setListeningState(false);

      if (result.contains("날씨")) {
        // "코디"가 포함되지 않은 경우에 수행할 동작을 여기에 작성합니다.
        String text = result;
        List<String> parts = text.split(" ");
        String cityName = parts[0];

        var translation =
            await translator.translate(cityName, from: 'ko', to: 'en');
        String cityTrans = translation.toString();
        sendTextMessageWeather(cityTrans);
        // 원하는 동작을 수행하도록 코드를 작성합니다.
      }
      sendTextMessageAI(result);
    }
  }

  Future<String> brifMorning(double latitude, double longitude) async {
    String weatherSummary =
        await AIHandler().getWeatherDataSummary2(latitude, longitude);
    String aiWeather =
        "$weatherSummary + 에 오늘 날씨 20글자로 표현해줘. 오늘 날씨에 맞는 옷차림을 구체적으로 자세하게 한국말로 알려줘. 마지막으로 오늘 하루를 응원하고, 축복해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);
    return aiResponse;
  }

  //날씨 정보를 위함
  void sendTextMessageWeather(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);

    String weatherSummary = await AIHandler().getWeatherDataSummary(message);
    //final weatherResponse = await _openAI.fetchWeatherData(message);
    String aiWeather =
        "$weatherSummary + $message에 오늘 날씨 20글자로 표현해줘. "
        "오늘 날씨에 맞는 옷차림을 구체적으로 자세하게 한국말로 알려줘. "
        "마지막으로 오늘 하루를 응원하고, 축복해줘.";
    final aiResponse = await _openAI.getResponse(aiWeather);
    removeTyping();

    final replyWidget = SizedBox(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SizedBox(
                width: 55,
              ),
              Text(
                "더 원하시는 정보가 있나요?",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 28,
              ),
              ElevatedButton(
                onPressed: () {
                  final replyWidget = TodayWeather(message);
                  final chats = ref.read(chatsProvider.notifier);
                  chats.add(ChatModel(
                    id: "oneday",
                    message: "$message의 오늘 하루 동안의 날씨:)",
                    isMe: false,
                    widget: replyWidget,
                  ));
                  chats.removeTyping2();
                },
                child: const Text(
                  "오늘 날씨",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  final replyWidget = FivedayWeather(message);
                  final chats = ref.read(chatsProvider.notifier);
                  chats.add(ChatModel(
                    id: "fiveday",
                    message: "$message의 5일간 날씨:)",
                    isMe: false,
                    widget: replyWidget,
                  ));
                  chats.removeTyping3();
                },
                child: const Text(
                  "5일간 날씨",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
    );

    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: DateTime.now().toString(),
      message: aiResponse,
      isMe: false,
      widget: replyWidget,
    ));

    setReplyingState(false);
  }

  // 특별한 날 뭘 입어야 할지
  void sendTextMessageCloth(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);

    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  // 짐 챙기기 도와줘
  void sendTextMessageBag(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);

    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  // AI와 대화하기
  void sendTextMessageAI(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);

    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  //필요없어 지금
  void setReplyingState(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  void setListeningState(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  void addToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));
  }
}
