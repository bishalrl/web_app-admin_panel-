import 'package:ecommerce/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeCards extends StatelessWidget {
  String? title;
  HomeCards({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueAccent.withOpacity(0.3),
            Colors.brown.withOpacity(0.3)
          ]),
          borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Text(
          title ?? "TITLE",
          style: EcoStyle.boldstyle,
        ),
      ),
    );
  }
}
