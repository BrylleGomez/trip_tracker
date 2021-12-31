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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
              onPressed: addNewRoute,
              icon: const Icon(Icons.add_location_alt_rounded),
              label: const Text('Add New Route')),
          ValueListenableBuilder<Box>(
            valueListenable: Hive.box(hiveRoutesBox).listenable(),
            builder: (context, box, widget) {
              return Text(box.get(0) ?? 'Heh');
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
