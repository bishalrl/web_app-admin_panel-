import 'package:ecommerce/utils/styles.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});
  static const String id = 'DashBoard';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          "DashBoard",
          style: EcoStyle.boldstyle,
        ),
      ),
    );
  }
}
