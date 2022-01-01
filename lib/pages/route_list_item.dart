import 'package:flutter/material.dart';

class RouteListItem extends StatelessWidget {
  final String routeName;
  final Function() onView;
  final Function() onEdit;
  final Function() onDelete;
  const RouteListItem(
      {Key? key,
      required this.routeName,
      required this.onView,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: InkWell(
        onTap: onView,
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
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
