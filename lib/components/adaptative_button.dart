import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).buttonColor),
            ),
            onPressed: () => onPressed(),
          )
        : ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (_) => Theme.of(context).primaryColor)),
            onPressed: () => onPressed(),
            child: Text(label),
          );
  }
}
