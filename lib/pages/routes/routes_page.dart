import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/widgets/confirm_dialog.dart';
import 'package:trip_tracker/pages/routes/route_list_item.dart';
import 'package:trip_tracker/utils/consts.dart';

import 'route_dialog.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  void handleViewRoute(BuildContext context, int key, TripRoute route) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RouteDialog(
            isViewing: true,
            routeKey: key,
            route: route,
          );
        });
  }

  void handleEditRoute(BuildContext context, int key, TripRoute route) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RouteDialog(
            routeKey: key,
            route: route,
          );
        });
  }

  void handleDeleteRoute(BuildContext context, int key) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
              message:
                  'Are you sure you want to delete this route? Doing so will also delete all trips associated with this route.',
              title: 'Delete Route',
              onConfirm: () => {confirmDeleteRoute(key)});
        });
  }

  void confirmDeleteRoute(int routeKeyToDelete) {
    final tripKeys = Hive.box<Trip>(hiveTripsBox).keys.cast<int>().toList();
    final trips = Hive.box<Trip>(hiveTripsBox).values.toList();
    int tripKeyToDelete = 0;
    for (final trip in trips) {
      if (trip.routeKey == routeKeyToDelete) {
        Hive.box<Trip>(hiveTripsBox).delete(tripKeys[tripKeyToDelete]);
      }
      tripKeyToDelete += 1;
    }
    Hive.box<TripRoute>(hiveRoutesBox).delete(routeKeyToDelete);
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
                  onView: () {
                    handleViewRoute(context, key, route);
                  },
                  onEdit: () {
                    handleEditRoute(context, key, route);
                  },
                  onDelete: () {
                    handleDeleteRoute(context, key);
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
