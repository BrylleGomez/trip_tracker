import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/home_page.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/utils/consts.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TripRouteAdapter());
  await Hive.openBox<TripRoute>(hiveRoutesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
