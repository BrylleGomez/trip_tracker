import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function() onConfirm;
  const ConfirmDialog(
      {Key? key,
      required this.message,
      required this.title,
      required this.onConfirm})
      : super(key: key);

  void _handleCancelPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _handleConfirmPressed(BuildContext context) {
    onConfirm();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(message),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _handleCancelPressed(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _handleConfirmPressed(context);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
