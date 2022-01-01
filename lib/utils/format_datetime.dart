import 'package:intl/intl.dart';

String formatTime(int hour, int minute) {
  final String hourStr = ((hour < 10) ? '0' : '') + hour.toString();
  final String minStr = ((minute < 10) ? '0' : '') + minute.toString();
  return '$hourStr:$minStr';
}

String formatDate(int dateInMilliseconds) {
  final dateFormat = DateFormat('MMM dd, yyyy');
  // final String hourStr = ((hour < 10) ? '0' : '') + hour.toString();
  // final String minStr = ((minute < 10) ? '0' : '') + minute.toString();
  // return '$hourStr:$minStr';
  return dateFormat
      .format(DateTime.fromMillisecondsSinceEpoch(dateInMilliseconds));
}
