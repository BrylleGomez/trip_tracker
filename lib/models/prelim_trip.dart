import 'package:hive/hive.dart';
part 'prelim_trip.g.dart';

@HiveType(typeId: 2)
class PrelimTrip {
  @HiveField(0)
  final int? startHour;
  @HiveField(1)
  final int? startMinute;
  @HiveField(2)
  final int? endHour;
  @HiveField(3)
  final int? endMinute;
  @HiveField(4)
  final String? date;
  @HiveField(5)
  final int? startMileage;
  @HiveField(6)
  final int? endMileage;
  @HiveField(7)
  final int? routeKey;
  @HiveField(8)
  final String? notes;

  PrelimTrip(
      {this.startHour,
      this.startMinute,
      this.endHour,
      this.endMinute,
      this.date,
      this.startMileage,
      this.endMileage,
      this.routeKey,
      this.notes});
}
