import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class PinkButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Icon? icon; // Accept an optional Icon

  const PinkButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          MyColors.pink,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: 10),
          // Show the icon if it's provided
          Text(text),
        ],
      ),
    );
  }
}
