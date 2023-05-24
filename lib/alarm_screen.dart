import 'package:flutter/material.dart';
import 'package:untitled/widgets/alarm_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

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
                    whichActionSelected = 1;
                    setState() {
                      whichActionSelected = 1;
                      print("1");
                    }
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
                    whichActionSelected = 2;
                    setState() {
                      whichActionSelected = 2;
                    }
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
                    print("3");
                    whichActionSelected = 3;
                    setState() {
                      whichActionSelected = 3;
                      print("3");
                    }
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
                    whichActionSelected = 4;
                    setState() {
                      whichActionSelected = 4;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )),
          ],
        ),
        // backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return AlarmCard();
          },
        ),
      ),
    );
  }
}
