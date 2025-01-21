import 'package:flutter/material.dart';

import '../core/constants.dart';

class NoteFormField extends StatelessWidget {
  const NoteFormField(
      {super.key,
      this.controller,
      this.labelText,
      this.hintText,
      this.autofocus = false,
      this.filled = false,
      this.fillColor,
        this.suffixIcon,
      this.validator,
        this.obscureText = false,
        this.textCapitalization = TextCapitalization.none,
        this.textInputAction,
        this.keyboardType,
      this.onChanged});

  final TextEditingController? controller;
  final String? labelText;
  final bool autofocus;
  final String? hintText;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: filled,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintText: hintText,
        hintStyle: TextStyle(color: gray500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red)),
      ),
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
    );
  }
}
