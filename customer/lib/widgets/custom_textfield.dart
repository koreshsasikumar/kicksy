import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool readOnly;
  const CustomTextfield({
    super.key,
    this.onChanged,
    this.validator,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.onTap,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      obscureText: obscureText,
      readOnly: readOnly,

      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
