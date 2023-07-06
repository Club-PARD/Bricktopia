import 'package:intl/intl.dart';

String formatTime(String time) {
  final hour = int.parse(time.split(':')[0]);
  final dateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, hour);
  final format = DateFormat('h a');
  return format.format(dateTime);
}
