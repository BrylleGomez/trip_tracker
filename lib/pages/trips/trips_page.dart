import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/utils/consts.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  void handleViewTrip(BuildContext context, int key, Trip trip) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return RouteDialog(
    //         isViewing: true,
    //         routeKey: key,
    //         route: route,
    //       );
    //     });
  }

  void handleEditTrip(BuildContext context, int key, Trip trip) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return RouteDialog(
    //         routeKey: key,
    //         route: route,
    //       );
    //     });
  }

  void handleDeleteTrip(BuildContext context, int key) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return ConfirmDialog(
    //           message: 'Are you sure you want to delete this route?',
    //           title: 'Delete Route',
    //           onConfirm: () =>
    //               {Hive.box<TripRoute>(hiveRoutesBox).delete(key)});
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<Trip>(hiveTripsBox).listenable(),
      builder: (context, box, widget) {
        List<int> keys = box.keys.cast<int>().toList();
        if (keys.isEmpty) {
          return const Center(
            child: Text('You have no trips.'),
          );
        } else {
          return Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                final int key = keys[index];
                final Trip trip = box.get(key);
                return Text(trip.toString());
                // return RouteListItem(
                //   routeName: trip.name,
                //   onView: () {
                //     handleViewTrip(context, key, trip);
                //   },
                //   onEdit: () {
                //     handleEditTrip(context, key, trip);
                //   },
                //   onDelete: () {
                //     handleDeleteTrip(context, key);
                //   },
                // );
              },
            ),
          );
        }
      },
    );
  }
}
