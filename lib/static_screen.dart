import 'package:flutter/material.dart';
import 'package:untitled/widgets/alarm_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int whichActionSelected = 1;
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
                    setState(
                      () => whichActionSelected = 1,
                    );
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
                    setState(() => whichActionSelected = 4);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  print("object");
                },
                icon: Icon(Icons.more_vert))
          ],
        ),
        // backgroundColor: Colors.black,
        body: (whichActionSelected == 1)
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AlarmCard();
                },
              )
            : ((whichActionSelected == 2)
                ? ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return AlarmCard();
                    },
                  )
                : ((whichActionSelected == 3)
                    ? ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return AlarmCard();
                        },
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
