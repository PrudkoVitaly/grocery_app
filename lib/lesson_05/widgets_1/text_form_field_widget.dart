import 'package:flutter/material.dart';

class TextFormFieldWidget_My extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  bool obscureText;

  TextFormFieldWidget_My({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
