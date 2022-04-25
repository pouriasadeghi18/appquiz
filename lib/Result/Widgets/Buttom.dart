import 'package:flutter/material.dart';

Widget Buttom(String text, Color color, Color TextColor, VoidCallback OnTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        onTap: OnTap,
        child: Container(
          height: 70,
          width: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: TextColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
