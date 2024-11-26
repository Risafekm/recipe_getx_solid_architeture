// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:flutter/material.dart';
import '../../core/theme/style.dart';

class TextArea extends StatelessWidget {
  String name;
  Widget prefixIcon;
  Widget suffixIcon;
  TextEditingController controller;
  String? Function(String?)? validator;
  bool obscureText;
  TextInputType keyboardType;
  int lines;

  TextArea({
    Key? key,
    required this.keyboardType,
    required this.name,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
    required this.suffixIcon,
    required this.obscureText,
    required this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: true,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: lines,
        style: Style().actorStyleBlack,
        decoration: InputDecoration(
          fillColor: const Color(0xFFFCFCFC),
          filled: true,
          label: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              name.toString(),
              style: Style().actorStyleBlack,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF1C4C74),
              width: 2,
            ),
          ),
          labelStyle: Style().actorStyleBlack,
          prefixIcon: prefixIcon,
          prefixIconColor: const Color(0xFF1C4C74),
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF1C4C74),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF52AF88),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFBF0808),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
