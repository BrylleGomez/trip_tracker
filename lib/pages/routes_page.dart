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
  final List<TripRoute> routes = [];

  void addNewRoute() {
    const newRoute = TripRoute(name: 'Name', path: 'Path');
    setState(() {
      routes.add(newRoute);
    });
    Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextButton.icon(
              onPressed: addNewRoute,
              icon: const Icon(Icons.add_location_alt_rounded),
              label: const Text('Add New Route')),
          ValueListenableBuilder<Box>(
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
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: routes.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     // access element from list using index
          //     // you can create and return a widget of your choice
          //     return Text(routes[index].name);
          //   },
          // ),
        ],
      ),
    );
  }
}
