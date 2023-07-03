import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';

class ChatNotifier extends StateNotifier<List<ChatModel>> {
  ChatNotifier() : super([]);

  void add(ChatModel chatModel) {
    state = [...state, chatModel];
  }

  void removeTyping() {
    state = state..removeWhere((chat) => chat.id == 'typing');
  }

  void removeTyping2() {
    state = state..removeWhere((chat) => chat.id == 'fiveday');
  }

  void removeTyping3() {
    state = state..removeWhere((chat) => chat.id == 'oneday');
  }
  void removeTypingWd() {
    state = state..removeWhere((chat) => chat.id == 'weady');
  }
}

final chatsProvider = StateNotifierProvider<ChatNotifier, List<ChatModel>>(
      (ref) => ChatNotifier(),
);
