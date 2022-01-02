import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trip_tracker/models/prelim_trip.dart';

import 'package:trip_tracker/pages/routes/routes_page.dart';
import 'package:trip_tracker/pages/trips/trip_dialog.dart';
import 'package:trip_tracker/pages/trips/trips_page.dart';

import 'pages/routes/route_dialog.dart';
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
          return const RouteDialog();
        });
  }

  void showNewTripDialog(BuildContext context) {
    PrelimTrip? prelimTrip = Hive.box<PrelimTrip>(hivePrelimTripBox).get(0);
    if (prelimTrip == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return TripDialog(
              dialogStatus: TripDialogStatus.adding,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return TripDialog(
              dialogStatus: TripDialogStatus.continuing,
              prelimTrip: prelimTrip,
            );
          });
    }
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
      case 1:
        showNewTripDialog(context);
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
