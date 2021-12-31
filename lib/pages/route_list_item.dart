import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final String routeName;
  const RouteListItem({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                routeName,
              ),
            ),
          ),
          const IconButton(onPressed: null, icon: Icon(Icons.edit)),
          const IconButton(onPressed: null, icon: Icon(Icons.delete))
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
