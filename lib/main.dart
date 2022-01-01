import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/home_page.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/models/prelim_trip.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/utils/consts.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TripRouteAdapter());
  Hive.registerAdapter(PrelimTripAdapter());
  Hive.registerAdapter(TripAdapter());
  await Hive.openBox<TripRoute>(hiveRoutesBox);
  await Hive.openBox<PrelimTrip>(hivePrelimTripBox);
  await Hive.openBox<Trip>(hiveTripsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
