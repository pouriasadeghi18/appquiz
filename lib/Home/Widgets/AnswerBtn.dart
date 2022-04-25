import 'package:flutter/material.dart';
import 'package:appquiz/Colors/constants.dart';
import 'package:appquiz/Home/HomePage.dart';

class AnswerBtn extends StatefulWidget {
  final String AnswerQuestion;
  late int numBtn;
  AnswerBtn({Key? key, required this.AnswerQuestion, required this.numBtn})
      : super(key: key);

  static int sendNumbtn() {
    return 2;
  }

  @override
  State<AnswerBtn> createState() => _AnswerBtnState();
}

class _AnswerBtnState extends State<AnswerBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.numBtn == 1) {
          setState(() {
            HomePage().CheckTrueAndFalse(true);
            print(HomePage.TrueFalseAnswer);
            print(widget.numBtn);
          });
        }
        if (widget.numBtn == 2) {
          setState(() {
            HomePage().CheckTrueAndFalse(false);
            print(HomePage.TrueFalseAnswer);
            print(widget.numBtn);
          });
        } else {}
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
            color: HomePage.TrueFalseAnswer && widget.numBtn == 1 ||
                    !HomePage.TrueFalseAnswer && widget.numBtn == 2
                ? KPurpleColor
                : KDarkBlueColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: HomePage.TrueFalseAnswer && widget.numBtn == 1 ||
                          !HomePage.TrueFalseAnswer && widget.numBtn == 2
                      ? Color.fromARGB(172, 180, 87, 223)
                      : Color.fromARGB(172, 80, 28, 221),
                  offset: Offset(-3, -3))
            ]),
        child: Text(
          widget.AnswerQuestion.toString(),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
