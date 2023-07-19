import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/select_city_screen.dart';
import 'package:untitled/widgets/alarm_card.dart';
import 'package:untitled/widgets/timezone_card.dart';

import 'external_libs/flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime _dateTime = DateTime.now();
  int whichActionSelected = 1;
  int alarmItems = 5;
  int timezoneItems = 5;
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool isRunning = false;
  List laps = [];
  bool assignmentButtonFlag = false;
  bool wavesButtonFlag = false;

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
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      isRunning = false;
      laps = [];
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
                            Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  itemCount: laps.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Lap # ${index + 1}",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                          Text(
                                            "${laps[index]}",
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            ((isRunning)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          // Lps
                                          lap();
                                        },
                                        child: Icon(
                                          Icons.reset_tv,
                                          size: 30,
                                        ), //Icon(Icons.play_arrow,size: 30,),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            stop();
                                          });
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
                                              reset();
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              hourMinuteSecond(),
                              Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: ListView(
                                      // This next line does the trick.
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          color: Colors.red,
                                          child: Icon(Icons.not_interested),
                                        ),
                                        Container(
                                          width: 100,
                                          color: Colors.blue,
                                          child: Icon(Icons.forest),
                                        ),
                                        Container(
                                          width: 100,
                                          color: Colors.green,
                                        ),
                                        Container(
                                          width: 100,
                                          color: Colors.yellow,
                                        ),
                                        Container(
                                          width: 100,
                                          color: Colors.orange,
                                        ),
                                        Container(
                                          width: 100,
                                          color: Colors.purple,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            wavesButtonFlag =
                                                (!wavesButtonFlag);
                                            assignmentButtonFlag = false;
                                          });
                                        },
                                        foregroundColor: Colors.grey,
                                        backgroundColor: (wavesButtonFlag
                                            ? Colors.blue
                                            : Colors.white),
                                        child: Icon(Icons.waves_sharp),
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.blue,
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 35,
                                        ),
                                      ),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            assignmentButtonFlag =
                                                (!assignmentButtonFlag);
                                            wavesButtonFlag = false;
                                          });
                                        },
                                        backgroundColor: (assignmentButtonFlag
                                            ? Colors.blue
                                            : Colors.white),
                                        foregroundColor: Colors.grey,
                                        child: Icon(Icons.assignment_rounded),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        : null))),
      ),
    );
  }

  /// SAMPLE
  Widget hourMinute12H() {
    return new TimePickerSpinner(
      is24HourMode: false,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinuteSecond() {
    return TimePickerSpinner(
      isShowSeconds: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinute15Interval() {
    return new TimePickerSpinner(
      spacing: 40,
      minutesInterval: 15,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }

  Widget hourMinute12HCustomStyle() {
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      minutesInterval: 15,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}

// Container(
//   margin: EdgeInsets.symmetric(vertical: 50),
//   child: Text(
//     _dateTime.hour
//             .toString()
//             .padLeft(2, '0') +
//         ':' +
//         _dateTime.minute
//             .toString()
//             .padLeft(2, '0') +
//         ':' +
//         _dateTime.second
//             .toString()
//             .padLeft(2, '0'),
//     style: TextStyle(
//         fontSize: 24,
//         fontWeight: FontWeight.bold),
//   ),
// ),
