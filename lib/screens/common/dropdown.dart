import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomDropdown extends StatefulWidget {
  List itemsList;
  String itemValue;
  String hint;
  Function(Object?)? onChanged;
  CustomDropdown(
      {super.key,
      required this.onChanged,
      required this.itemValue,
      required this.itemsList,
      required this.hint});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            color: kGinColor, borderRadius: BorderRadius.circular(10)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            hint: Text(
              widget.hint,
              style: (TextStyle(color: kDarkGreenColor, fontSize: 18)),
            ),
            value: widget.itemValue,
            onChanged: widget.onChanged,
            items: widget.itemsList.map((valueItem) {
              return DropdownMenuItem(
                alignment: Alignment.centerLeft,
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
      ),
    );
  }
}
