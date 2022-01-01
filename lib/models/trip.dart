import 'package:hive/hive.dart';
part 'trip.g.dart';

@HiveType(typeId: 3)
class Trip {
  @HiveField(0)
  final DateTime startTime;
  @HiveField(1)
  final DateTime endTime;
  @HiveField(2)
  final int startMileage;
  @HiveField(3)
  final int endMileage;
  @HiveField(4)
  final int routeKey;
  @HiveField(5)
  final String notes;
  @HiveField(6)
  final int tripDuration;
  @HiveField(7)
  final int tripDistance;
  @HiveField(8)
  final DateTime date;
  @HiveField(9)
  final String weekday;

  const Trip(
      {required this.startTime,
      required this.endTime,
      required this.startMileage,
      required this.endMileage,
      required this.routeKey,
      required this.notes,
      required this.tripDuration,
      required this.tripDistance,
      required this.date,
      required this.weekday});
}
