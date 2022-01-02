import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import 'package:trip_tracker/models/prelim_trip.dart';

import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/models/trip.dart';
import 'package:trip_tracker/utils/consts.dart';
import 'package:trip_tracker/utils/format_datetime.dart';
import 'package:trip_tracker/utils/datetime_utils.dart';
import 'package:trip_tracker/utils/weekday_utils.dart';

class TripDialog extends StatefulWidget {
  final TripDialogStatus dialogStatus;
  final int? tripKey;
  final Trip? trip;
  final PrelimTrip? prelimTrip;
  const TripDialog(
      {Key? key,
      required this.dialogStatus,
      this.tripKey,
      this.trip,
      this.prelimTrip})
      : assert((dialogStatus == TripDialogStatus.adding &&
                tripKey == null &&
                trip == null) ||
            (dialogStatus == TripDialogStatus.editing &&
                tripKey != null &&
                trip != null) ||
            (dialogStatus == TripDialogStatus.viewing &&
                tripKey != null &&
                trip != null) ||
            (dialogStatus == TripDialogStatus.continuing &&
                prelimTrip != null)),
        super(key: key);

  @override
  _TripDialogState createState() => _TripDialogState();
}

class _TripDialogState extends State<TripDialog> {
  late bool _isViewingOrEditing;
  late bool _isViewing;
  late bool _isContinuing;

  final _formKey = GlobalKey<FormState>();

  late int _startHour;
  late int _startMinute;
  late int _endHour;
  late int _endMinute;
  late int _date;
  final _startMileageFieldController = TextEditingController();
  final _endMileageFieldController = TextEditingController();
  late int _routeKey;
  final _notesFieldController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    _isViewingOrEditing = widget.dialogStatus == TripDialogStatus.viewing ||
        widget.dialogStatus == TripDialogStatus.editing;
    _isViewing = widget.dialogStatus == TripDialogStatus.viewing;
    _isContinuing = widget.dialogStatus == TripDialogStatus.continuing;

    _startHour = _isViewingOrEditing
        ? widget.trip!.startHour
        : _isContinuing
            ? (widget.prelimTrip!.startHour ?? DateTime.now().hour)
            : DateTime.now().hour;
    _startMinute = _isViewingOrEditing
        ? widget.trip!.startMinute
        : _isContinuing
            ? (widget.prelimTrip!.startMinute ?? DateTime.now().minute)
            : DateTime.now().minute;
    _endHour = _isViewingOrEditing
        ? widget.trip!.endHour
        : _isContinuing
            ? (widget.prelimTrip!.endHour ?? DateTime.now().hour)
            : DateTime.now().hour;
    _endMinute = _isViewingOrEditing
        ? widget.trip!.endMinute
        : _isContinuing
            ? (widget.prelimTrip!.endMinute ?? DateTime.now().minute)
            : DateTime.now().minute;
    _date = _isViewingOrEditing
        ? widget.trip!.date
        : _isContinuing
            ? (widget.prelimTrip!.date ?? DateTime.now().millisecondsSinceEpoch)
            : DateTime.now().millisecondsSinceEpoch;
    _routeKey = _isViewingOrEditing
        ? widget.trip!.routeKey
        : _isContinuing
            ? (widget.prelimTrip!.routeKey ??
                (Hive.box<TripRoute>(hiveRoutesBox).keys.isNotEmpty ? 0 : -1))
            : (Hive.box<TripRoute>(hiveRoutesBox).keys.isNotEmpty ? 0 : -1);

    _startMileageFieldController.text = _isViewingOrEditing
        ? widget.trip!.startMileage.toString()
        : (_isContinuing && widget.prelimTrip!.startMileage != null)
            ? widget.prelimTrip!.startMileage.toString()
            : '';
    _endMileageFieldController.text = _isViewingOrEditing
        ? widget.trip!.endMileage.toString()
        : (_isContinuing && widget.prelimTrip!.endMileage != null)
            ? widget.prelimTrip!.endMileage.toString()
            : '';
    _notesFieldController.text = _isViewingOrEditing
        ? widget.trip!.notes
        : _isContinuing
            ? widget.prelimTrip!.notes.toString()
            : '';
  }

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
    bool isValidTime =
        isValidTimeRange(_startHour, _startMinute, _endHour, _endMinute);
    if (!isValidTime) {
      setState(() {
        _errorMessage = 'Please enter valid ending time!';
      });
      return;
    } else {
      setState(() {
        _errorMessage = '';
      });
    }
    if (_formKey.currentState!.validate()) {
      final startMileage = int.parse(_startMileageFieldController.text);
      final endMileage = int.parse(_endMileageFieldController.text);
      final trip = Trip(
          startHour: _startHour,
          startMinute: _startMinute,
          endHour: _endHour,
          endMinute: _endMinute,
          date: _date,
          startMileage: startMileage,
          endMileage: endMileage,
          routeKey: _routeKey,
          notes: _notesFieldController.text,
          tripDuration:
              getDuration(_startHour, _startMinute, _endHour, _endMinute),
          tripDistance: endMileage - startMileage,
          weekday: WeekdayUtils.enumToStr(WeekdayUtils.weekdayFromDatetime(
              DateTime.fromMillisecondsSinceEpoch(_date))));
      if (widget.dialogStatus == TripDialogStatus.adding ||
          widget.dialogStatus == TripDialogStatus.continuing) {
        Hive.box<Trip>(hiveTripsBox).add(trip);
      } else {
        Hive.box<Trip>(hiveTripsBox).put(widget.tripKey, trip);
      }
      Hive.box<PrelimTrip>(hivePrelimTripBox).delete(0);
      Navigator.of(context).pop();
    }
  }

  void _handleKeepPressed(BuildContext context) {
    final int? startMileage = int.tryParse(_startMileageFieldController.text);
    final int? endMileage = int.tryParse(_endMileageFieldController.text);
    final prelimTrip = PrelimTrip(
        startHour: _startHour,
        startMinute: _startMinute,
        endHour: _endHour,
        endMinute: _endMinute,
        date: _date,
        startMileage: startMileage,
        endMileage: endMileage,
        routeKey: _routeKey,
        notes: _notesFieldController.text);
    Hive.box<PrelimTrip>(hivePrelimTripBox).put(0, prelimTrip);
    Navigator.of(context).pop();
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

    // Get list of routes with index
    List<int> routeKeys =
        Hive.box<TripRoute>(hiveRoutesBox).keys.cast<int>().toList();
    List<TripRouteWithIndex> routes = Hive.box<TripRoute>(hiveRoutesBox)
        .values
        .mapIndexed((idx, route) => TripRouteWithIndex(
            routeIndex: routeKeys[idx], name: route.name, path: route.path))
        .toList();

    // Render widget
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start Time
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
                // End Time
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
                // Date
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
                // Mileage
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 125,
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
                              return "Enter valid number!";
                            }
                          },
                          enabled: !isViewing,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 125,
                        child: TextFormField(
                          controller: _endMileageFieldController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'End Mileage',
                              border: OutlineInputBorder(),
                              isDense: true),
                          validator: (value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                (int.parse(_endMileageFieldController.text) >
                                    int.parse(
                                        _startMileageFieldController.text))) {
                              return null;
                            } else {
                              return "Enter valid number!";
                            }
                          },
                          enabled: !isViewing,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Route
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      const Text('Route:'),
                      const SizedBox(width: 8.0),
                      SizedBox(
                        width: 200,
                        child: DropdownButtonFormField<int>(
                          hint: const Text('No routes.'),
                          value: _routeKey,
                          icon: const Icon(Icons.arrow_downward),
                          // elevation: 16,
                          // style: const TextStyle(color: Colors.deepPurple),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          onChanged: !isViewing
                              ? (int? newRouteIdx) {
                                  setState(() {
                                    _routeKey = newRouteIdx!;
                                  });
                                }
                              : null,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), isDense: true),
                          items: routes
                              .map((route) => DropdownMenuItem<int>(
                                    value: route.routeIndex,
                                    child: Text(route.name),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value != null && value >= 0) {
                              return null;
                            } else {
                              return "Please select a route!";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Notes
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    controller: _notesFieldController,
                    decoration: const InputDecoration(
                        labelText: 'Notes',
                        border: OutlineInputBorder(),
                        isDense: true),
                    enabled: !isViewing,
                  ),
                ),
                // Calculated Info
                if (_isViewing) ...[
                  // Duration
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:
                        Text('Duration: ${widget.trip!.tripDuration} minutes'),
                  ),
                  // Distance
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                        'Distance: ${widget.trip!.tripDistance} kilometers'),
                  ),
                  // Weekday
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Day of the Week: ${widget.trip!.weekday}'),
                  )
                ],
                //  Error Message
                if (_errorMessage != '')
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(_errorMessage,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0)),
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
                  _handleKeepPressed(context);
                },
                child: const Text('Keep'),
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

class TripRouteWithIndex extends TripRoute {
  int routeIndex;

  TripRouteWithIndex(
      {required this.routeIndex, required String name, required String path})
      : super(name: name, path: path);
}
