import 'package:flutter/material.dart';
import 'package:trip_tracker/pages/routes_page.dart';
import 'package:trip_tracker/pages/trips_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  final pages = [const RoutesPage(), const TripsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Tracker'),
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Routes'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Trips')
        ],
        onTap: (idx) => {
          setState(() {
            _currentPageIndex = idx;
          })
        },
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
