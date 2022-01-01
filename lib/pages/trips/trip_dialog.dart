import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/utils/format_datetime.dart';

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
  int _startHour = DateTime.now().hour;
  int _startMinute = DateTime.now().minute;
  int _endHour = DateTime.now().hour;
  int _endMinute = DateTime.now().minute;
  int _date = DateTime.now().millisecondsSinceEpoch;
  final _startMileageFieldController = TextEditingController();
  final _endMileageFieldController = TextEditingController();

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _startHour, minute: _startMinute),
    );
    if (selectedTime != null) {
      setState(() {
        _startHour = selectedTime.hour;
        _startMinute = selectedTime.minute;
      });
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _endHour, minute: _endMinute),
    );
    if (selectedTime != null) {
      setState(() {
        _endHour = selectedTime.hour;
        _endMinute = selectedTime.minute;
      });
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.fromMillisecondsSinceEpoch(_date),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100));
    if (selectedDate != null) {
      setState(() {
        _date = selectedDate.millisecondsSinceEpoch;
      });
    }
  }

  void _handleCancelPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handleSavePressed(BuildContext context) {
    // if (widget.route == null && widget.routeKey == null) {
    //   if (_formKey.currentState!.validate()) {
    //     final newRoute = TripRoute(
    //         name: _nameFieldController.text, path: _pathFieldController.text);
    //     Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
    //     Navigator.of(context).pop();
    //   }
    // } else if (widget.route != null && widget.routeKey != null) {
    //   if (_formKey.currentState!.validate()) {
    //     final updatedRoute = TripRoute(
    //         name: _nameFieldController.text, path: _pathFieldController.text);
    //     Hive.box<TripRoute>(hiveRoutesBox).put(widget.routeKey, updatedRoute);
    //     Navigator.of(context).pop();
    //   }
    // }
  }

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
                Row(
                  children: [
                    const Text('Start Time: '),
                    TextButton(
                      onPressed: isViewing
                          ? null
                          : () {
                              _selectStartTime(context);
                            },
                      child: Text(formatTime(_startHour, _startMinute)),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('End Time: '),
                    TextButton(
                      onPressed: isViewing
                          ? null
                          : () {
                              _selectEndTime(context);
                            },
                      child: Text(formatTime(_endHour, _endMinute)),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text('Date: '),
                    TextButton(
                      onPressed: isViewing
                          ? null
                          : () {
                              _selectDate(context);
                            },
                      child: Text(formatDate(_date)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _startMileageFieldController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Start Mileage',
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter your starting mileage!";
                      }
                    },
                    enabled: !isViewing,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _endMileageFieldController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'End Mileage',
                        border: OutlineInputBorder(),
                        isDense: true),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter your ending mileage!";
                      }
                    },
                    enabled: !isViewing,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                )
              ],
            )),
      ),
      actions: isViewing
          ? []
          : [
              TextButton(
                onPressed: () {
                  _handleCancelPressed(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _handleSavePressed(context);
                },
                child: const Text('Save'),
              ),
            ],
    );
  }
}

enum TripDialogStatus { adding, continuing, editing, viewing }
