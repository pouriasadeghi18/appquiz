import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Colors/constants.dart';

class PointScreen extends StatefulWidget {
  PointScreen({Key? key, required this.Status}) : super(key: key);

  String Status;

  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: Column(children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/Images/PointScreenPic/result.png',
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 120,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 500,
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40.0)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Text(
                                'user',
                                style: TextStyle(
                                    fontSize: 35.0, fontFamily: "Slabo"),
                              ),
                              Spacer(),
                              Icon(
                                Icons.check,
                                size: 35,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.close,
                                size: 35,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.check_box_outline_blank,
                                size: 35,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 412,
                        child: FutureBuilder(
                          future: LoadData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              print(snapshot.data);
                              List<String> ResultList = snapshot.data;
                                    print(ResultList);
                              return ListView.builder(
                                  itemCount: ResultList.length,
                                  itemBuilder: (context, index) {
                                    String Name = ResultList[index]
                                        .split("/")[0];
                                    int Correct = int.parse(
                                        ResultList[index].split(
                                            "/")[1]);
                                    int Wrong = int.parse(
                                        ResultList[index].split(
                                            "/")[2]);
                                    int NoAnswer = int.parse(
                                        ResultList[index].split(
                                            "/")[3]);
                                    return SingleChildScrollView(child: Column(children: [
                                      ResultUser(Name, Correct, Wrong, NoAnswer, widget.Status),
                                    ],),);

                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ]),
                  ),
                ]),
              ),
            )));
  }

  Widget ResultUser(String Name, int correct, int wrong, int noAnswer,
      String Status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
          borderRadius:
          const BorderRadius.horizontal(left: Radius.circular(30)),
          gradient: LinearGradient(colors: [
            Status == 'Winner' ? Colors.green : Colors.red,
            Colors.white
          ])),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              Name,
              style: const TextStyle(fontSize: 35.0, fontFamily: "Slabo"),
            ),
            const Spacer(),
            Text(
              correct.toString(),
              style: const TextStyle(
                fontSize: 35,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 35,
            ),
            Text(
              wrong.toString(),
              style: const TextStyle(
                fontSize: 35,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 35,
            ),
            Text(
              noAnswer.toString(),
              style: const TextStyle(
                fontSize: 35,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> LoadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('scores') ?? [];
  }
}
