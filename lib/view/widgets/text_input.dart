import 'package:flutter/material.dart';

import '../../constants.dart';

class TextInputFiled extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String mylabelText;
  final bool toHide;

  TextInputFiled(
      {Key? key,
      required this.controller,
      required this.myIcon,
      required this.mylabelText,
      this.toHide =false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: mylabelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
