import 'package:appquiz/Model/QuestionModel.dart';
import 'package:flutter/material.dart';
import 'package:appquiz/Colors/constants.dart';
import 'package:appquiz/Home/HomePage.dart';

// ignore: non_constant_identifier_names
Widget CirculeNumberWidget(int num, int CurrentQuestion) {
  Color color = KLightBlueColor;
  late int Size = questionList.length;
  late int temp = num - 1;
  if (temp == CurrentQuestion) {
    if (temp == Size) {
      if (HomePage.StatusList[temp] == false) {
        color = KLightRedColor;
      } else if (HomePage.StatusList[temp] == true) {
        color = KLightGreenColor;
      }
    }
    color = Colors.white;
    // ignore: unrelated_type_equality_checks
  } else if (HomePage.StatusList[temp] == false) {
    color = KLightRedColor;
  } else if (HomePage.StatusList[temp] == true) {
    color = KLightGreenColor;
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    height: temp == CurrentQuestion ? 70 : 60,
    width: temp == CurrentQuestion ? 70 : 60,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(
        child: Text(
      "$num",
      style: TextStyle(
          color: temp == CurrentQuestion ? Colors.blue : Colors.white,
          fontSize: temp == CurrentQuestion ? 40 : 30,
          fontWeight: FontWeight.bold),
    )),
  );
}
