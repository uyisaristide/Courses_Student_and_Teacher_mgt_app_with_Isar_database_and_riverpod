import 'package:flutter/material.dart';

import '../../../constants.dart';

class EntityButtons extends StatelessWidget {
  final Color buttonColor;
  final IconData? mediaIcon;
  final String media;
  final Function() onPressed;

  const EntityButtons(
      {required this.buttonColor,
      required this.mediaIcon,
      required this.media,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: kDarkGreenColor,
      ),
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kSpiritedGreen)),
        onPressed: onPressed,

        icon: Icon(
          mediaIcon,
          color: Colors.white,
        ),
        label: Text(
          media,
          style: const TextStyle(fontSize: 17),
        ),
        // textColor: Colors.white,
        // color: buttonColor,
        // elevation: 0,
      ),
    );
  }
}
