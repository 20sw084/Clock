import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;

  const CountdownTimer({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  Duration _elapsedTime = Duration.zero; // Initialize elapsed time
  bool isScreenOn = true;

  void startTimer() {
    // Start the timer with the total duration
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final secondsPassed = _elapsedTime.inSeconds + 1;
      setState(() {
        _elapsedTime = Duration(seconds: secondsPassed);

        if (_elapsedTime >= widget.duration) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the time left
    final timeLeft = widget.duration - _elapsedTime;
    final percentageRemaining = timeLeft.inSeconds / widget.duration.inSeconds;

    // Format the time left into minutes and seconds
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(timeLeft.inHours.remainder(24));
    final minutes = strDigits(timeLeft.inMinutes.remainder(60));
    final seconds = strDigits(timeLeft.inSeconds.remainder(60));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0,),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: percentageRemaining,
                    strokeWidth: 6,
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
                  ),
                ),
                Text(
                  '$hours:$minutes:$seconds',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TODO: show hours, minutes as available when it is not zero.
                Positioned(
                  bottom: 90,
                  child: Text(
                    'Total ${widget.duration.inHours} hours, ${widget.duration.inMinutes % 60} minutes, and ${widget.duration.inSeconds % 60} seconds',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  child: IconButton(icon: Icon(Icons.wb_sunny_sharp), onPressed: () { setState(() {
                    isScreenOn = !(isScreenOn);
                  }); },
                  color: isScreenOn?Colors.blue:Colors.grey,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(onPressed: null, child: Icon(Icons.abc, color: Colors.blue, size: 40,),shape: CircleBorder(),backgroundColor: Colors.white,),
                FloatingActionButton(onPressed: null, child: Icon(Icons.play_arrow, color: Colors.blue, size: 40,),shape: CircleBorder(),backgroundColor: Colors.white,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
