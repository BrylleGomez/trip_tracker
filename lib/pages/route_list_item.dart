import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final String routeName;
  const RouteListItem({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          routeName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
