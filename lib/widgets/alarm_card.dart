import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatefulWidget {
  const AlarmCard({Key? key}) : super(key: key);

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  bool stateOfLight = false;
  String selectedAmPm = 'AM';
  String selectedHour = '01';
  String selectedMinute = '00';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
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
                scale: 1.0,
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
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog();
            },
          );
        },
        onDoubleTap: (){
          // TODO: Delete Card Functionality should be implemented here.
        },
      ),
    );
  }

}

class CustomDialog extends StatefulWidget {
  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool stateOfButton = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
                  scale: 1.0,
                  child: Switch(
                    value: stateOfButton,
                    onChanged: (bool value) {
                      setState(
                            () {
                            stateOfButton = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Scrollable buttons for AM/PM, Hours (01-12), Minutes (00-59)
                ScrollButton(items: ['AM', 'PM'], title: 'AM/PM'),
                ScrollButton(items: List.generate(12, (index) => '${index + 1}'), title: 'Hours'),
                ScrollButton(items: List.generate(60, (index) => '${index.toString().padLeft(2, '0')}'), title: 'Minutes'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Additional Settings button pressed
                    // Implement additional settings logic here
                  },
                  child: Text('Additional Settings'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Done button pressed
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollButton extends StatefulWidget {
  final List<String> items;
  final String title;

  const ScrollButton({required this.items, required this.title});

  @override
  _ScrollButtonState createState() => _ScrollButtonState();
}

class _ScrollButtonState extends State<ScrollButton> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(widget.title),
        // SizedBox(height: 8),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width*0.2,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedValue = widget.items[index];
              });
            },
            children: List<Widget>.generate(widget.items.length, (int index) {
              return Center(
                child: Text(widget.items[index]),
              );
            }),
          ),
        ),
        // Text('Selected: $selectedValue'),
      ],
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
