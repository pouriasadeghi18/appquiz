import 'package:flutter/material.dart';

Widget PointRow(IconData icon, String text, String Point, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(
        icon,
        size: 35,
        color: color,
      ),
      Text(
        text,
        style:
            TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      Text(
        Point,
        style:
            TextStyle(color: color, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
