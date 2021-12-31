import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:trip_tracker/pages/routes_page.dart';
import 'package:trip_tracker/pages/trips_page.dart';

import 'models/route.dart';
import 'utils/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIdx = 0;

  final List<Page> _pages = [
    Page(
      navbarIcon: Icons.location_on,
      label: 'Routes',
      widget: const RoutesPage(),
      actionIcon: Icons.add_location_alt_rounded,
      actionOnPressed: () {
        const newRoute = TripRoute(name: 'Name', path: 'Path');
        Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
      },
    ),
    Page(
      navbarIcon: Icons.list,
      label: 'Trips',
      widget: const TripsPage(),
      actionIcon: Icons.add_circle,
      actionOnPressed: () {
        const newRoute = TripRoute(name: 'Name', path: 'Path');
        Hive.box<TripRoute>(hiveRoutesBox).add(newRoute);
      },
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_pageIdx].label),
      ),
      body: _pages[_pageIdx].widget,
      floatingActionButton: FloatingActionButton(
        onPressed: _pages[_pageIdx].actionOnPressed,
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
  final Function() actionOnPressed;
  const Page(
      {required this.navbarIcon,
      required this.label,
      required this.widget,
      required this.actionIcon,
      required this.actionOnPressed});
}
