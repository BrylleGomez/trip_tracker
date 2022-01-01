import 'package:hive/hive.dart';
part 'prelim_trip.g.dart';

@HiveType(typeId: 2)
class PrelimTrip {
  @HiveField(0)
  final DateTime? startTime;
  @HiveField(1)
  final DateTime? endTime;
  @HiveField(2)
  final int? startMileage;
  @HiveField(3)
  final int? endMileage;
  @HiveField(4)
  final int? routeKey;
  @HiveField(5)
  final String? notes;

  const PrelimTrip(
      {this.startTime,
      this.endTime,
      this.startMileage,
      this.endMileage,
      this.routeKey,
      this.notes});
}
