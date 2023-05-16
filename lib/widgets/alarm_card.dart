import 'package:flutter/material.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({Key? key}) : super(key: key);

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool stateOfLight = false;
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
                  text: TextSpan(
                    text: "12:00",
                    style: CustomTextStyle.formalStyle1,
                    children: [
                      TextSpan(
                        text: "am",
                        style: CustomTextStyle.formalStyle2,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Once",
                  style: CustomTextStyle.formalStyle2,
                ),
              ],
            ),
            Transform.scale(
              scale: 1.5,
              child: Switch(
                value: stateOfLight,
                onChanged: (bool value) {
                  setState(
                    () {
                      stateOfLight = value;
                    },
                  );
                },
              ),
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
}
