import 'dart:io';

import 'dart:async';
import 'package:appquiz/Colors/constants.dart';
import 'package:appquiz/Point/PointScreen.dart';
import 'package:appquiz/Result/Widgets/Buttom.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'Widgets/PointRow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final ResultList;

  ResultScreen({Key? key, this.ResultList}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    late Size size = MediaQuery.of(context).size;
    String status = "";

    if (widget.ResultList[0] > widget.ResultList[1] &&
        widget.ResultList[0] > widget.ResultList[2]) {
      status = "Winner";
    } else if (widget.ResultList[0] < widget.ResultList[1] ||
        widget.ResultList[0] < widget.ResultList[2]) {
      status = "Loser";
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    height: 600,
                    width: size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        widget.ResultList[0] > widget.ResultList[1] &&
                                widget.ResultList[0] > widget.ResultList[2]
                            ? KLightGreenColor
                            : KLightRedColor,
                        Colors.white
                      ], begin: Alignment.topCenter, end: Alignment.center),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(90.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 600,
                          width: size.width - 55,
                          child: Stack(alignment: Alignment.center, children: [
                            Positioned(
                                top: 100,
                                child: Container(
                                  height: 500,
                                  width: size.width - 55,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(60.0),
                                        bottom: Radius.circular(90.0)),
                                    color: Color.fromARGB(210, 255, 255, 255),
                                  ),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 180,
                                    ),
                                    Text(
                                      status == "Winner"
                                          ? "You are Winner"
                                          : "You are Loser",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: status == 'Winner'
                                            ? Colors.green
                                            : Colors.red,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Divider(
                                      height: 2,
                                      thickness: 3,
                                      endIndent: 30,
                                      indent: 30,
                                      color: status == "Winner"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: size.width - 180,
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        PointRow(
                                            Icons.check,
                                            "correct",
                                            widget.ResultList[0].toString(),
                                            Colors.green),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        PointRow(
                                            Icons.close,
                                            "wrong",
                                            widget.ResultList[1].toString(),
                                            Colors.red),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        PointRow(
                                            Icons.check_box_outline_blank,
                                            "white",
                                            widget.ResultList[2].toString(),
                                            Colors.grey),
                                      ]),
                                    )
                                  ]),
                                )),
                            Positioned(
                                top: -10,
                                child: Image.asset(
                                  status == "Winner"
                                      ? 'assets/Images/ResultPic/Success.png'
                                      : 'assets/Images/ResultPic/Unsuccessful.png',
                                  height: 250,
                                ))
                          ]),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttom("Play Again", Colors.orange, Colors.black, (() {
                      onPlayAgainPressed(context);
                    })),
                    Buttom("Result", Colors.white, Colors.black, (() {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO_REVERSED,
                        animType: AnimType.SCALE,
                        headerAnimationLoop: false,
                        body: Column(children: [
                          Text("Please Type your Name"),
                          TextField(
                            controller: widget.controller,
                          )
                        ]),
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          NavigatorToPointScreen(context, status);
                        },
                      ).show();
                    })),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  NavigatorToPointScreen(context, String Status) {
    onOkpressed(context,Status);
  }

  void onPlayAgainPressed(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text(
                  "would you like play again?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          Phoenix.rebirth(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.red,
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.red),
                            primary: Colors.red),
                        onPressed: () {
                          onNoPressed(context);
                        },
                        child: const Text('No'),
                      ),
                    ),
                  ],
                )
              ]),
            ));
  }

  void onNoPressed(BuildContext context) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void onOkpressed(context,String Status) async {


     SharedPreferences pref = await SharedPreferences.getInstance();

     List<String> list = pref.getStringList('scores')?? [];

     list.add('${widget.controller.text}/${widget.ResultList[0]}/${widget.ResultList[1]}/${widget.ResultList[2]}');
     await pref.setStringList('scores', list);
     Navigator.push(context, MaterialPageRoute(builder: (context)=> PointScreen(Status: Status)));

  }
}
