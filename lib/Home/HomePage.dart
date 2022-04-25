// ignore_for_file: non_constant_identifier_names

import 'package:appquiz/Home/Widgets/NextButton.dart';
import 'package:appquiz/Model/QuestionModel.dart';
import 'package:appquiz/Result/ResultScreen.dart';
import 'package:appquiz/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:appquiz/Colors/constants.dart';
import 'Widgets/CirculeNumberWidget.dart';
import 'Widgets/AnswerBtn.dart';
import 'Widgets/FinishAnswerBtn.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  late int CurrentQuestionNumber = 0;
  late Size size;
  static bool TrueFalseAnswer = false;
  static List StatusList = [];

  void CheckTrueAndFalse(bool TrueOrFalse) {
    TrueFalseAnswer = TrueOrFalse;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questionList.length; i++) {
      HomePage.StatusList.add(0);
    }

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if ((animation.value * 100).round() >= 98) {
            NextQuestionBtn(true);
            if (controller.isAnimating) {
              controller.reset();
              controller.forward();
            }
          }
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    widget.size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [KLightBlueBackgroundColor, KDarkBlueBackgroundColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 15,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: animation.value,
                    backgroundColor: KLightBlueColor,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              questionListRow(widget.CurrentQuestionNumber),
              SizedBox(
                height: 500,
                width: widget.size.width,
                child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: widget.size.width - 230,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: widget.size.width - 150,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    child: Container(
                      width: widget.size.width - 60,
                      padding: const EdgeInsets.all(10),
                      height: 350,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Colors.white, Colors.lightBlueAccent],
                              begin: Alignment.topRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.white.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.75),
                              blurRadius: 70,
                            )
                          ]),
                      child: Column(children: [
                        const SizedBox(
                          height: 120,
                        ),
                        SizedBox(
                          height: 160,
                          child: Text(
                            questionList[widget.CurrentQuestionNumber].question,
                            style: const TextStyle(
                              color: KDarkBlueColor,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AnswerBtn(
                              AnswerQuestion:
                                  questionList[widget.CurrentQuestionNumber]
                                      .answer1,
                              numBtn: 1,
                            ),
                            AnswerBtn(
                              AnswerQuestion:
                                  questionList[widget.CurrentQuestionNumber]
                                      .answer2,
                              numBtn: 2,
                            ),

                            //--------------------------------------------------------
                          ],
                        )
                      ]),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      questionList[widget.CurrentQuestionNumber].imageAddress,
                      height: 220,
                    ),
                  ),
                ]),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NextButton(OnTap: NextQuestionBtn),
                  FinishAnswerBtn(OnTap: MyNavigator),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  MyNavigator() {
    controller.repeat();
    controller.dispose();
    List<int> ResultList = TransferTheResult();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(
                  ResultList: ResultList,
                )));
  }

  Widget questionListRow(int current) {
    List<Widget> list = [];
    for (int i = 0; i < questionList.length; i++) {
      list.add(CirculeNumberWidget(i + 1, current));
    }
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(children: list),
    );
  }

  NextQuestionBtn(bool FromTimer) {
    scrollController.animateTo(widget.CurrentQuestionNumber * 50,
        duration: const Duration(microseconds: 1000), curve: Curves.easeInOut);
    if (FromTimer) {
      HomePage.StatusList[widget.CurrentQuestionNumber] = null;
    } else {
      CheckAnswer();
    }

    if (widget.CurrentQuestionNumber >= questionList.length - 1) {
      MyNavigator();
    } else {
      widget.CurrentQuestionNumber++;
      controller.reset();
      controller.forward();
      setState(() {});
    }
  }

  CheckAnswer() {
    int myAnswer = HomePage.TrueFalseAnswer ? 1 : 2;

    bool Status = questionList[widget.CurrentQuestionNumber].isRight(myAnswer);
    HomePage.StatusList[widget.CurrentQuestionNumber] = Status;
  }

  List<int> TransferTheResult() {
    int RightAnswer = 0;
    int WrongAnswer = 0;
    int unanswered = 0;
    for (var item in HomePage.StatusList) {
      if (item == true) {
        RightAnswer++;
      } else if (item == false) {
        WrongAnswer++;
      } else {
        unanswered++;
      }
    }
    return [RightAnswer, WrongAnswer, unanswered];
  }
}
