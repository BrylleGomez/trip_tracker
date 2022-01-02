import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/pages/trips/trip_dialog.dart';
import 'package:trip_tracker/utils/consts.dart';
import 'package:trip_tracker/widgets/confirm_dialog.dart';

import 'trip_list_item.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  void handleViewTrip(BuildContext context, int key, Trip trip) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TripDialog(
            dialogStatus: TripDialogStatus.viewing,
            tripKey: key,
            trip: trip,
          );
        });
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
              message: 'Are you sure you want to delete this trip?',
              title: 'Delete Trip',
              onConfirm: () => {Hive.box<Trip>(hiveTripsBox).delete(key)});
        });
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
              reverse: true,
              shrinkWrap: true,
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                final int key = keys[index];
                final Trip trip = box.get(key);
                return TripListItem(
                  trip: trip,
                  onView: () {
                    handleViewTrip(context, key, trip);
                  },
                  onEdit: () {
                    handleEditTrip(context, key, trip);
                  },
                  onDelete: () {
                    handleDeleteTrip(context, key);
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
