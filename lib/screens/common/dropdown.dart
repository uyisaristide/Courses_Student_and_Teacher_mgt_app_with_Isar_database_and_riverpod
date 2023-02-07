import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomDropdown extends StatefulWidget {
  List itemsList;
  String itemValue;
  String hint;
  CustomDropdown(
      {super.key,required this.itemValue, required this.itemsList, required this.hint});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            color: kGinColor, borderRadius: BorderRadius.circular(10)),
        child: DropdownButton(
          hint: Text(
            widget.hint,
            style: (TextStyle(color: kDarkGreenColor, fontSize: 18)),
          ),
          value: widget.itemValue,
          
          onChanged: (newValue) {
            setState(() {
              widget.itemValue = newValue as String;
            });
          },
          items: widget.itemsList.map((valueItem) {
            return DropdownMenuItem(
              value: valueItem,
              child: Text(
                valueItem,
                style: TextStyle(
                    color: kDarkGreenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
