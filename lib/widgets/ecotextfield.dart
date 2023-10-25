import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  final String hinttext;
  Icon? icon;
  final String? Function(String?)? validator;
  bool ispassword;
  final TextEditingController controller;

  EcoTextField({super.key, 
    this.icon,
    required this.hinttext,
    required this.controller,
    this.validator,
    this.ispassword = false,
    // Set a default value for ispassword
  });

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(17),
      child: TextFormField(
        obscureText: widget.ispassword, // Use the 'ispassword' value directly
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.icon,
          border: const OutlineInputBorder(), // Use OutlineInputBorder for a border
          hintText: widget.hinttext,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
