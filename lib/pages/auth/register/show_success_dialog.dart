import 'package:flutter/material.dart';
import 'package:kicksy/extension/extension.dart';

class ShowSuccessDialog extends StatelessWidget {
  const ShowSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.height,
          const Text(
            "Registration Successful!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
