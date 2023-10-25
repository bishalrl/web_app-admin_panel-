import 'package:ecommerce/utils/styles.dart';
import 'package:flutter/material.dart';

class Update_Product_Screen extends StatelessWidget {
  const Update_Product_Screen({super.key});
  static const String id = 'Update_Product_Screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          "Update_Product_Screen",
          style: EcoStyle.boldstyle,
        ),
      ),
    );
  }
}
