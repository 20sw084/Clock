import 'dart:async';
import 'package:flutter/material.dart';
import 'package:alarm_app/screens/select_city_screen.dart';
import 'package:alarm_app/widgets/alarm_card.dart';
import 'package:alarm_app/widgets/timezone_card.dart';
import 'package:provider/provider.dart';
import '../external_libs/flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../providers/time_provider.dart';

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
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.alarm,
                    color:
                        (whichActionSelected == 1) ? Colors.black : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => whichActionSelected = 1);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.watch_later_sharp,
                      color: (whichActionSelected == 2)
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
                    setState(() => whichActionSelected = 2);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.timer,
                      color: (whichActionSelected == 3)
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
                    setState(() => whichActionSelected = 3);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.hourglass_empty_sharp,
                      color: (whichActionSelected == 4)
                          ? Colors.black
                          : Colors.grey),
                  onPressed: () {
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
                const PopupMenuItem<int>(
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
                        child: Consumer<TimeModel>(
                          builder: (context, timeProvider, child) {
                            // Todo: Should have 03 in time instead of 3
                            return Column(
                              children: [
                                Text(
                                  '${timeProvider.currentTime}',
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text("Current: ${timeProvider.currentDate}"),
                              ],
                            );
                          },
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
                                  (wavesButtonFlag)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 18.0),
                                          child: Container(
                                            height: 70,
                                            child: ListView(
                                              // This next line does the trick.
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                Container(
                                                  width: 100,
                                                  // color: Colors.red,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          Icons.not_interested),
                                                      Text("None"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.blue,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.forest),
                                                      Text("Forest"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.green,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.nights_stay),
                                                      Text("Summer night"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.yellow,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons.beach_access),
                                                      Text("Beach"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.orange,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(
                                                          Icons.cloudy_snowing),
                                                      Text("Summer rain"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.purple,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Icon(Icons
                                                          .fire_extinguisher),
                                                      Text("Stove fire"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : (assignmentButtonFlag)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 18.0),
                                              child: Container(
                                                height: 70,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        // This next line does the trick.
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: 4,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 100,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "00:03:00",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                      "Brush Teeth"),
                                                                ],
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  15,
                                                                ),
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        child: Icon(Icons.add),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                  // Container(
                                  //   height: 100,
                                  //   child: ListView(
                                  //     // This next line does the trick.
                                  //     scrollDirection: Axis.horizontal,
                                  //     children: <Widget>[
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.red,
                                  //         child: Icon(Icons.not_interested),
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.blue,
                                  //         child: Icon(Icons.forest),
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.green,
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.yellow,
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.orange,
                                  //       ),
                                  //       Container(
                                  //         width: 100,
                                  //         color: Colors.purple,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
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
