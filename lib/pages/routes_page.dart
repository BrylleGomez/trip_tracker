import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/pages/route_list_item.dart';
import 'package:trip_tracker/utils/consts.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  void handleDeleteRoute(int key) {
    Hive.box<TripRoute>(hiveRoutesBox).delete(key);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<TripRoute>(hiveRoutesBox).listenable(),
      builder: (context, box, widget) {
        List<int> keys = box.keys.cast<int>().toList();
        if (keys.isEmpty) {
          return const Center(
            child: Text('You have no routes.'),
          );
        } else {
          return Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                final int key = keys[index];
                final TripRoute route = box.get(key);
                return RouteListItem(
                  routeName: route.name,
                  onDelete: () {
                    handleDeleteRoute(key);
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}
