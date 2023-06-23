import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/select_city_screen.dart';
import 'package:untitled/widgets/alarm_card.dart';
import 'package:untitled/widgets/timezone_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int whichActionSelected = 1;
  int alarmItems = 5;
  int timezoneItems = 5;
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer timer;
  bool isRunning = false;
  List laps = [];

  void start() {
    isRunning = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;

        digitSeconds = (seconds < 10) ? "0$seconds" : "$seconds";
        digitMinutes = (minutes < 10) ? "0$minutes" : "$minutes";
        digitHours = (hours < 10) ? "0$hours" : "$hours";
      });
    });
  }

  void stop() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      isRunning = false;
    });
  }

  void lap() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.alarm,
                    color:
                        (whichActionSelected == 1) ? Colors.black : Colors.grey,
                  ),
                  onTap: () {
                    setState(() => whichActionSelected = 1);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Icon(Icons.watch_later_sharp,
                      color: (whichActionSelected == 2)
                          ? Colors.black
                          : Colors.grey),
                  onTap: () {
                    setState(() => whichActionSelected = 2);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Icon(Icons.timer,
                      color: (whichActionSelected == 3)
                          ? Colors.black
                          : Colors.grey),
                  onTap: () {
                    setState(() => whichActionSelected = 3);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  child: Icon(Icons.hourglass_empty_sharp,
                      color: (whichActionSelected == 4)
                          ? Colors.black
                          : Colors.grey),
                  onTap: () {
                    setState(
                      () => whichActionSelected = 4,
                    );
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Settings"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                // TODO: theme chnge on screen
                print("Settings Screen here.");
              }
            }),
          ],
        ),
        // backgroundColor: Colors.black,
        body: (whichActionSelected == 1)
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView.builder(
                    itemCount: alarmItems,
                    itemBuilder: (context, index) {
                      return AlarmCard();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FloatingActionButton(
                      onPressed: (() {
                        setState(() {
                          alarmItems++;
                        });
                      }),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              )
            : ((whichActionSelected == 2)
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            Text(
                              "06:30:50",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Current: 26/05/2023"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              // shrinkWrap: true,
                              itemCount: timezoneItems,
                              itemBuilder: (context, index) {
                                return TimezoneCard();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: FloatingActionButton(
                                onPressed: (() {
                                  setState(() {
                                    timezoneItems++;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectCityScreen()),
                                  );
                                }),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : ((whichActionSelected == 3)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "$digitHours:$digitMinutes:$digitSeconds",
                              style: TextStyle(
                                fontSize: 65,
                              ),
                            ),
                            ((isRunning)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          reset();
                                        },
                                        child: Icon(
                                          Icons.reset_tv,
                                          size: 30,
                                        ), //Icon(Icons.play_arrow,size: 30,),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          stop();
                                        },
                                        child: Icon(
                                          Icons.pause,
                                          size: 30,
                                        ), //Icon(Icons.play_arrow,size: 30,),
                                      ),
                                    ],
                                  )
                                : ((seconds == 0)
                                    ? FloatingActionButton(
                                        onPressed: () {
                                          start();
                                        },
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 30,
                                        ), //Icon(Icons.play_arrow,size: 30,),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FloatingActionButton(
                                            onPressed: () {
                                              // Lps
                                            },
                                            child: Icon(
                                              Icons.laptop,
                                              size: 30,
                                            ), //Icon(Icons.play_arrow,size: 30,),
                                          ),
                                          FloatingActionButton(
                                            onPressed: () {
                                              start();
                                            },
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 30,
                                            ), //Icon(Icons.play_arrow,size: 30,),
                                          ),
                                        ],
                                      ))
                            // FloatingActionButton(
                            //         onPressed: () {
                            //           start();
                            //         },
                            //         child: Icon(
                            //           Icons.play_arrow,
                            //           size: 30,
                            //         ), //Icon(Icons.play_arrow,size: 30,),
                            //       )
                            ),
                            // FloatingActionButton(
                            //   onPressed: null,
                            //   child: ((stopwatch.isRunning)?Row(
                            //     children: [
                            //       Icon(Icons.reset_tv,size: 30,),
                            //       Icon(Icons.pause,size: 30,),
                            //     ],
                            //   ):Icon(Icons.play_arrow,size: 30,)), //Icon(Icons.play_arrow,size: 30,),
                            // )
                            // ListView.builder(
                            //     itemCount: 3,
                            //     itemBuilder: (context, index) {
                            //       return AlarmCard();
                            //     },
                            //   ),
                          ],
                        ),
                      )
                    : ((whichActionSelected == 4)
                        ? ListView.builder(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return AlarmCard();
                            },
                          )
                        : null))),
      ),
    );
  }
}
