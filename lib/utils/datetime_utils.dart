int getDuration(int startHour, int startMinute, int endhour, int endMinute) {
  DateTime startTime = DateTime(2022, 1, 1, startHour, startMinute);
  DateTime endTime = DateTime(2022, 1, 1, endhour, endMinute);
  Duration difference = startTime.difference(endTime);
  return difference.inMinutes;
}

// int isValidTimeRange(int startHour, int startMinute, int endhour, int endMinute) {
//   DateTime startTime = DateTime(2022, 1, 1, startHour, startMinute);
//   DateTime endTime = DateTime(2022, 1, 1, endhour, endMinute);
//   Duration difference = startTime.difference(endTime);
//   return difference.inMinutes;
// }