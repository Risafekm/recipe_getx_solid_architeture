// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_super_parameters
import 'package:flutter/material.dart';
import '../../core/theme/style.dart';

class Button extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Button({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.purple,
        ),
        child: Center(
          child: Text(
            text,
            style: Style().actorStyleWhite,
          ),
        ),
      ),
    );
  }
}
