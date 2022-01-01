import 'package:flutter/material.dart';
import 'package:trip_tracker/models/trip.dart';

class TripDialog extends StatefulWidget {
  final TripDialogStatus dialogStatus;
  final int? tripKey;
  final Trip? trip;
  const TripDialog(
      {Key? key, required this.dialogStatus, this.tripKey, this.trip})
      : assert((dialogStatus == TripDialogStatus.adding &&
                tripKey == null &&
                trip == null) ||
            (dialogStatus == TripDialogStatus.editing &&
                tripKey != null &&
                trip != null) ||
            (dialogStatus == TripDialogStatus.viewing &&
                tripKey != null &&
                trip != null)),
        super(key: key);

  @override
  _TripDialogState createState() => _TripDialogState();
}

class _TripDialogState extends State<TripDialog> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get title
    String title;
    switch (widget.dialogStatus) {
      case TripDialogStatus.adding:
        title = 'New Trip';
        break;
      case TripDialogStatus.continuing:
        title = 'Finalize Trip';
        break;
      case TripDialogStatus.editing:
        title = 'Edit Trip';
        break;
      case TripDialogStatus.viewing:
        title = 'View Trip';
        break;
      default:
        title = 'View Trip';
    }

    // Get whether viewing
    bool isViewing = widget.dialogStatus == TripDialogStatus.viewing;

    // Render widget
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: null,
                  decoration: const InputDecoration(
                      labelText: 'Trip Name',
                      border: OutlineInputBorder(),
                      isDense: true),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return null;
                    } else {
                      return "Please enter a trip name!";
                    }
                  },
                  enabled: !isViewing,
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            )),
      ),
    );
  }
}

enum TripDialogStatus { adding, continuing, editing, viewing }
