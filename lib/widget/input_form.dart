



import 'dart:developer';

import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {

  final TextEditingController ? controller;
  final String ? hint;
  final Widget ? prefix;
  final EdgeInsets ? margin;
  final double ? width,height;
  final bool isDisable;
  final bool password;
  final String? Function(dynamic value) ? validator;
  const InputFormField({super.key,this.password=false,this.isDisable=false,this.height,this.width,this.margin,this.prefix,this.controller,this.hint, required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56,
      width: width,
      margin: margin,
      decoration: const BoxDecoration(
        color: Color(0xFFf3f3f3),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Center(
        child: TextFormField(
          validator: validator,
          controller: controller,
          onChanged: (value) => log(value),
          obscureText: password,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabled: !isDisable,
            enabledBorder: InputBorder.none,
            hintText: hint,
            prefixIcon: prefix,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFFBDBDBD),
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF212121),
            ),
          ),
        ),
      ),
    );
  }
}
