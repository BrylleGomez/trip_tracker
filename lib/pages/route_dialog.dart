import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/route.dart';
import 'package:trip_tracker/utils/consts.dart';

class RouteDialog extends StatefulWidget {
  final bool isViewing;
  final int? routeKey;
  final TripRoute? route;
  const RouteDialog(
      {Key? key, this.isViewing = false, this.routeKey, this.route})
      : assert((routeKey == null && route == null && !isViewing) ||
            (routeKey != null && route != null && isViewing) ||
            (routeKey != null && route != null && !isViewing)),
        super(key: key);

  @override
  State<RouteDialog> createState() => _RouteDialogState();
}

class _RouteDialogState extends State<RouteDialog> {
  final _nameFieldController = TextEditingController();
  final _pathFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleCancelPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handleSavePressed(BuildContext context) {
    if (widget.route == null && widget.routeKey == null) {
      if (_formKey.currentState!.validate()) {
        final newRoute = TripRoute(
            name: _nameFieldController.text, path: _pathFieldController.text);
        Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
        Navigator.of(context).pop();
      }
    } else if (widget.route != null && widget.routeKey != null) {
      if (_formKey.currentState!.validate()) {
        final updatedRoute = TripRoute(
            name: _nameFieldController.text, path: _pathFieldController.text);
        Hive.box<TripRoute>(hiveRoutesBox).put(widget.routeKey, updatedRoute);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFieldController.text = widget.route?.name ?? '';
    _pathFieldController.text = widget.route?.path ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isViewing
          ? 'View Route'
          : widget.route != null
              ? 'Edit Route'
              : 'Add Route'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameFieldController,
                decoration: const InputDecoration(
                    labelText: 'Route Name',
                    border: OutlineInputBorder(),
                    isDense: true),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return "Please enter a route name!";
                  }
                },
                enabled: !widget.isViewing,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _pathFieldController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Path Details',
                    border: OutlineInputBorder(),
                    isDense: true),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return "Please enter the path details!";
                  }
                },
                enabled: !widget.isViewing,
              )
            ],
          ),
        ),
      ),
      actions: widget.isViewing
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
