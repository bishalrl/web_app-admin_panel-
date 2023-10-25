import 'package:ecommerce/utils/styles.dart';
import 'package:flutter/material.dart';

class Delete_Product_Screen extends StatelessWidget {
  const Delete_Product_Screen({super.key});
  static const String id = 'Delete_Product_Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          "Delete_Product_Screen",
          style: EcoStyle.boldstyle,
        ),
      ),
    );
  }
}
