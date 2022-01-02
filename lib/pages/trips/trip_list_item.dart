import 'package:flutter/material.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/utils/format_datetime.dart';

class TripListItem extends StatelessWidget {
  final Trip trip;
  final Function() onView;
  final Function() onEdit;
  final Function() onDelete;
  const TripListItem(
      {Key? key,
      required this.trip,
      required this.onView,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: InkWell(
        onTap: onView,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                    '${formatDate(trip.date)} → ${formatTime(trip.startHour, trip.startMinute)} - ${formatTime(trip.endHour, trip.endMinute)}'),
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
