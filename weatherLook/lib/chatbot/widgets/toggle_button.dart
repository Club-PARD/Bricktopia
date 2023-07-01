// import 'package:flutter/material.dart';
// import 'text_and_voice_field.dart';

// class ToggleButton extends StatefulWidget {
//   final VoidCallback _sendTextMessage;
//   final VoidCallback _sendVoiceMessage;
//   final InputMode _inputMode;
//   final bool _isReplying;
//   final bool _isListening;
//   const ToggleButton({
//     super.key,
//     required InputMode inputMode,
//     required VoidCallback sendTextMessage,
//     required VoidCallback sendVoiceMessage,
//     required bool isReplying,
//     required bool isListening,
//   })  : _inputMode = inputMode,
//         _sendTextMessage = sendTextMessage,
//         _sendVoiceMessage = sendVoiceMessage,
//         _isReplying = isReplying,
//         _isListening = isListening;

//   @override
//   State<ToggleButton> createState() => _ToggleButtonState();
// }

// class _ToggleButtonState extends State<ToggleButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Theme.of(context).colorScheme.onPrimary,
//         foregroundColor: Theme.of(context).colorScheme.primary,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(15),
//       ),
//       onPressed: widget._isReplying
//           ? null
//           : widget._inputMode == InputMode.text
//           ? widget._sendTextMessage
//           : widget._sendVoiceMessage,
//       child: Container(
//         width: 25, // 원하는 너비
//         height: 25, // 원하는 높이
//         child: Image.asset(
//           widget._inputMode == InputMode.text
//               ? "icon/icon_send.png"
//               : widget._isListening
//               ? "icon/icon_mic.png"
//               : "icon/icon_mic.png",
//           fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조정
//         ),
//       ),
//     );
//   }
// }
