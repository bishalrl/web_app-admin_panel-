import 'package:ecommerce/widgets/ecobutton.dart';
import 'package:flutter/material.dart';

class EcoDialogue extends StatelessWidget {
  final String? title;

  const EcoDialogue({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      actions: [
        EcoButton(
            buttonName: 'Close',
            onTap: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
