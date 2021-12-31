import 'package:hive/hive.dart';
part 'route.g.dart';

@HiveType(typeId: 1)
class TripRoute {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String path;

  const TripRoute({required this.name, required this.path});
}
