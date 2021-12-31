import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/route.dart';

import 'package:trip_tracker/pages/routes_page.dart';
import 'package:trip_tracker/pages/trips_page.dart';

import 'utils/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIdx = 0;

  void showNewRouteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const RouteDialog(
            routeKey: null,
            route: null,
          );
        });
  }

  final List<Page> _pages = [
    const Page(
      navbarIcon: Icons.location_on,
      label: 'Routes',
      widget: RoutesPage(),
      actionIcon: Icons.add_location_alt_rounded,
    ),
    const Page(
      navbarIcon: Icons.list,
      label: 'Trips',
      widget: TripsPage(),
      actionIcon: Icons.add_circle,
    )
  ];

  void handleFloatingActionOnPressed(BuildContext context, int pageIdx) {
    switch (pageIdx) {
      case 0:
        showNewRouteDialog(context);
        break;
      default:
        showNewRouteDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_pageIdx].label),
      ),
      body: _pages[_pageIdx].widget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleFloatingActionOnPressed(context, _pageIdx);
        },
        child: Icon(_pages[_pageIdx].actionIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(_pages[0].navbarIcon), label: _pages[0].label),
          BottomNavigationBarItem(
              icon: Icon(_pages[1].navbarIcon), label: _pages[1].label)
        ],
        onTap: (idx) => {
          setState(() {
            _pageIdx = idx;
          })
        },
        currentIndex: _pageIdx,
      ),
    );
  }
}

class Page {
  final IconData navbarIcon;
  final String label;
  final Widget widget;
  final IconData actionIcon;
  const Page({
    required this.navbarIcon,
    required this.label,
    required this.widget,
    required this.actionIcon,
  });
}

class RouteDialog extends StatefulWidget {
  final int? routeKey;
  final TripRoute? route;
  const RouteDialog({Key? key, this.routeKey, this.route})
      : assert((routeKey == null && route == null) ||
            (routeKey != null && route != null)),
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
    if (widget.route == null) {
      if (_formKey.currentState!.validate()) {
        final newRoute = TripRoute(
            name: _nameFieldController.text, path: _pathFieldController.text);
        Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.route != null ? 'Edit Route' : 'Add Route'),
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
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _handleCancelPressed(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            _handleSavePressed(context);
          },
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}
