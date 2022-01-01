import 'package:hive/hive.dart';
part 'trip.g.dart';

@HiveType(typeId: 3)
class Trip {
  @HiveField(0)
  final int startHour;
  @HiveField(1)
  final int startMinute;
  @HiveField(2)
  final int endHour;
  @HiveField(3)
  final int endMinute;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final int startMileage;
  @HiveField(6)
  final int endMileage;
  @HiveField(7)
  final int routeKey;
  @HiveField(8)
  final String notes;
  @HiveField(9)
  final int tripDuration;
  @HiveField(10)
  final int tripDistance;
  @HiveField(11)
  final String weekday;

  const Trip(
      {required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute,
      required this.date,
      required this.startMileage,
      required this.endMileage,
      required this.routeKey,
      required this.notes,
      required this.tripDuration,
      required this.tripDistance,
      required this.weekday});
}
