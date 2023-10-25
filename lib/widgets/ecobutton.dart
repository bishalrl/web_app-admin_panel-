import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  final String? buttonName;
  VoidCallback?
      onTap; // Use 'final' instead of 'var' or 'String?' for non-nullability
  final bool isLogInButton; // Use 'final' and remove '?' for non-nullability

  EcoButton(
      {Key? key,
      required this.buttonName,
      required this.onTap,
      this.isLogInButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLogInButton
              ? Colors.black
              : Colors.white, // Corrected the condition
          border: Border.all(color: Colors.black), // Border for both cases
        ),
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
        width: double.infinity,
        child: Center(
          child: Text(
            buttonName ?? "Button",
            style: TextStyle(
              color: isLogInButton
                  ? Colors.white
                  : Colors.black, // Text color based on the condition
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
