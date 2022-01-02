int getDuration(int startHour, int startMinute, int endhour, int endMinute) {
  DateTime startTime = DateTime(2022, 1, 1, startHour, startMinute);
  DateTime endTime = DateTime(2022, 1, 1, endhour, endMinute);
  Duration difference = endTime.difference(startTime);
  return difference.inMinutes;
}

bool isValidTimeRange(
    int startHour, int startMinute, int endhour, int endMinute) {
  DateTime startTime = DateTime(2022, 1, 1, startHour, startMinute);
  DateTime endTime = DateTime(2022, 1, 1, endhour, endMinute);
  Duration difference = endTime.difference(startTime);
  return difference.inMinutes > 0;
}
