// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:appquiz/Colors/constants.dart';
import 'package:appquiz/Home/HomePage.dart';
import 'package:appquiz/Model/QuestionModel.dart';
import 'package:flutter/material.dart';

import '../../Result/ResultScreen.dart';

class NextButton extends StatelessWidget {
  // ignore: non_constant_identifier_names
  var OnTap;
  NextButton({Key? key, required this.OnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KNextButtonColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: InkWell(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        onTap: () {
          OnTap(false);
        },
        child: Container(
          width: 200,
          height: 70,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: const Center(
              child: Text(
            'Next',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
