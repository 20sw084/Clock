import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';

class TimezoneCard extends StatefulWidget {
  const TimezoneCard({Key? key}) : super(key: key);

  @override
  State<TimezoneCard> createState() => _TimezoneState();
}

class _TimezoneState extends State<TimezoneCard> {
  // bool stateOfLight = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    text: "12:00",
                    style: CustomTextStyle.formalStyle1,
                    children: [
                      TextSpan(
                        text: "Melbourne",
                        style: CustomTextStyle.formalStyle3,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "28 May am",
                      style: CustomTextStyle.formalStyle2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1, // Thickness
                        height: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "5 hrs ahead",
                      style: CustomTextStyle.formalStyle2,
                    ),
                  ],
                ),
              ],
            ),
            const AnalogClock(
              decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
              ), // decoration
              width: 150.0,
              isLive: true,
              hourHandColor: Colors.white,
              minuteHandColor: Colors.white,
              showSecondHand: false,
              showTicks: false,
              showDigitalClock: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextStyle {
  static const TextStyle formalStyle1 = TextStyle(
// fontFamily: fontFamily,
  color: Colors.black,
    fontSize: 40,
    // fontWeight: FontWeight.bold,
  );
  static const TextStyle formalStyle2 = TextStyle(
// fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 14,
// fontWeight: FontWeight.bold,
  );
  static const TextStyle formalStyle3 = TextStyle(
// fontFamily: fontFamily,
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
}
