import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final String routeName;
  final Function() onDelete;
  const RouteListItem(
      {Key? key, required this.routeName, required this.onDelete})
      : super(key: key);

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
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
            color: Colors.blue,
          )
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
