import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.initialValue,
    this.controller,
    required this.label,
    this.validator,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.keyboardType,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
  TextEditingController? controller;

  final String label;
  final String hintText;
  final String? initialValue;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorColor: kDarkGreenColor,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: kDarkGreenColor,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18.0),
          filled: true,
          fillColor: kGinColor,
          prefixIcon: Icon(
            icon,
            size: 24.0,
            color: kDarkGreenColor,
          ),
          label: Text(
            label,
            style: TextStyle(color: kDarkGreenColor, fontSize: 18),
          ),
          hintText: hintText,
          
          hintStyle: TextStyle(
            color: kDarkGreenColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kGinColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: kDarkGreenColor),
          ),
        ),
        initialValue:initialValue ,
        onChanged: onChanged,
      ),
    );
  }
}
