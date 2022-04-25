import 'package:appquiz/Colors/constants.dart';
import 'package:flutter/material.dart';

class FinishAnswerBtn extends StatelessWidget {
  var OnTap;
  FinishAnswerBtn({Key? key, required this.OnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: KPurpleColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: InkWell(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        onTap: () {
          OnTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: const Center(
              child: Icon(
            Icons.assistant_photo_sharp,
            color: Colors.white,
            size: 35,
          )),
        ),
      ),
    );
  }
}
