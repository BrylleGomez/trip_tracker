import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/utils/consts.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<Box>(
        valueListenable: Hive.box<TripRoute>(hiveRoutesBox).listenable(),
        builder: (context, box, widget) {
          List<int> keys = box.keys.cast<int>().toList();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: keys.length,
            itemBuilder: (BuildContext context, int index) {
              final int key = keys[index];
              final dynamic route = box.get(key);
              return Text(route.name);
            },
          );
        },
      ),
    );
  }
}
