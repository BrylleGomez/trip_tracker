String formatTime(int hour, int minute) {
  final String hourStr = ((hour < 10) ? '0' : '') + hour.toString();
  final String minStr = ((minute < 10) ? '0' : '') + minute.toString();
  return '$hourStr:$minStr';
}
