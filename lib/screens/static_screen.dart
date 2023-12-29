import 'dart:async';
import 'package:flutter/material.dart';
import 'package:alarm_app/screens/select_city_screen.dart';
import 'package:alarm_app/widgets/alarm_card.dart';
import 'package:alarm_app/widgets/timezone_card.dart';
import 'package:provider/provider.dart';
import '../external_libs/flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../providers/time_provider.dart';
import '../widgets/countdown_timer.dart';

bool isTimerOn = false;

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
  Icon currentIcon = Icon(Icons.waves_sharp);

  late Timer _timer;
  Duration _elapsedTime = Duration.zero; // Initialize elapsed time
  bool isScreenOn = true;
  bool _isRunning = true;
  Duration duration = Duration(minutes: 2);
  Icon _timerState = Icon(
    Icons.pause,
    color: Colors.blue,
    size: 40,
  );
  Icon _pauseState = Icon(
    Icons.pause,
    color: Colors.blue,
    size: 40,
  );
  Icon _playingState = Icon(
    Icons.play_arrow,
    color: Colors.blue,
    size: 40,
  );

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final secondsPassed = _elapsedTime.inSeconds + 1;
      setState(() {
        _elapsedTime = Duration(seconds: secondsPassed);

        if (_elapsedTime >= duration) {
          _timer.cancel();
        }
      });
    });
  }

  void pauseTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    setState(() {
      _isRunning = false;
      _timerState = _playingState;
    });
  }

  void resumeTimer() {
    startTimer();
    setState(() {
      _isRunning = true;
      _timerState = _pauseState;
    });
  }


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

  void refresh(){
    if (mounted) {
      setState(() {
        isTimerOn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the time left
    final timeLeft = duration - _elapsedTime;
    final percentageRemaining = timeLeft.inSeconds / duration.inSeconds;

    // Format the time left into minutes and seconds
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hourss = strDigits(timeLeft.inHours.remainder(24));
    final minutess = strDigits(timeLeft.inMinutes.remainder(60));
    final secondss = strDigits(timeLeft.inSeconds.remainder(60));

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
                        ? ((isTimerOn)? CountdownTimer(duration: duration):
        Column(
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
                                                      Icon(Icons.not_interested),
                                                      Text("None"),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.blue,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentIcon = Icon(Icons.forest);
                                                      });
                                                    },
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
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.green,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentIcon = Icon(Icons.nights_stay);
                                                      });
                                                    },
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
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.yellow,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentIcon = Icon(Icons.beach_access);
                                                      });
                                                    },
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
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.orange,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentIcon = Icon(Icons.cloudy_snowing);
                                                      });
                                                    },
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
                                                ),
                                                Container(
                                                  width: 100,
                                                  // color: Colors.purple,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        currentIcon = Icon(Icons.fire_extinguisher);
                                                      });
                                                    },
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
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                // TODO: editing the time
                                                              },
                                                              onDoubleTap: (){
                                                                // TODO: Show edit/delete popup
                                                              },
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
                                        child: currentIcon,
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.blue,
                                        onPressed: () {
                                          setState(() {
                                            isTimerOn = true;
                                          });
                                        },
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
                            ): null))),
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
          duration = Duration(hours: time.hour, minutes: time.minute, seconds: time.second,);
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
// class CountdownTimer extends StatefulWidget {
//   final Duration duration;
//
//   const CountdownTimer({
//     Key? key,
//     required this.duration,
//   }) : super(key: key);
//
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }
//
// class _CountdownTimerState extends State<CountdownTimer> {
//   late Timer _timer;
//   Duration _elapsedTime = Duration.zero; // Initialize elapsed time
//   bool isScreenOn = true;
//   bool _isRunning = true;
//   Icon _timerState = Icon(
//     Icons.pause,
//     color: Colors.blue,
//     size: 40,
//   );
//   Icon _pauseState = Icon(
//     Icons.pause,
//     color: Colors.blue,
//     size: 40,
//   );
//   Icon _playingState = Icon(
//     Icons.play_arrow,
//     color: Colors.blue,
//     size: 40,
//   );
//
//   void startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       final secondsPassed = _elapsedTime.inSeconds + 1;
//       setState(() {
//         _elapsedTime = Duration(seconds: secondsPassed);
//
//         if (_elapsedTime >= widget.duration) {
//           _timer.cancel();
//         }
//       });
//     });
//     // todo: setstate chahye yahan
//     isTimerOn = false;
//   }
//
//   void pauseTimer() {
//     if (_timer.isActive) {
//       _timer.cancel();
//     }
//     setState(() {
//       _isRunning = false;
//       _timerState = _playingState;
//     });
//   }
//
//   void resumeTimer() {
//     startTimer();
//     setState(() {
//       _isRunning = true;
//       _timerState = _pauseState;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Calculate the time left
//     final timeLeft = widget.duration - _elapsedTime;
//     final percentageRemaining = timeLeft.inSeconds / widget.duration.inSeconds;
//
//     // Format the time left into minutes and seconds
//     String strDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = strDigits(timeLeft.inHours.remainder(24));
//     final minutes = strDigits(timeLeft.inMinutes.remainder(60));
//     final seconds = strDigits(timeLeft.inSeconds.remainder(60));
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 50.0,
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: 300,
//                   height: 300,
//                   child: CircularProgressIndicator(
//                     value: percentageRemaining,
//                     strokeWidth: 6,
//                     backgroundColor: Colors.blue,
//                     valueColor:
//                     AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
//                   ),
//                 ),
//                 Text(
//                   '$hours:$minutes:$seconds',
//                   style: TextStyle(
//                     fontSize: 48,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // TODO: show hours, minutes as available when it is not zero.
//                 Positioned(
//                   bottom: 90,
//                   child: Text(
//                     'Total ${widget.duration.inHours} hours, ${widget.duration.inMinutes % 60} minutes, and ${widget.duration.inSeconds % 60} seconds',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 15,
//                   child: IconButton(
//                     icon: Icon(Icons.wb_sunny_sharp),
//                     onPressed: () {
//                       setState(() {
//                         isScreenOn = !(isScreenOn);
//                       });
//                     },
//                     color: isScreenOn ? Colors.blue : Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(50.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 FloatingActionButton(
//                   onPressed: (){
//                     setState(() {
//                       _AlarmScreenState as = _AlarmScreenState();
//                       pauseTimer();
//                       as.refresh();
//                     });
//                   },
//                   child: Icon(
//                     Icons.kebab_dining_sharp,
//                     color: Colors.blue,
//                     size: 40,
//                   ),
//                   shape: CircleBorder(),
//                   backgroundColor: Colors.white,
//                 ),
//                 FloatingActionButton(
//                   onPressed: () {
//                     // pause the _timer
//                     setState(() {
//                       if(_isRunning){
//                         pauseTimer();
//                       }
//                       else{
//                         resumeTimer();
//                       }
//                     });
//                   },
//                   child: _timerState,
//                   shape: CircleBorder(),
//                   backgroundColor: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
