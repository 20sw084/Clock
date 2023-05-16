import 'package:flutter/material.dart';
import 'package:untitled/widgets/alarm_card.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int whichActionSelected = 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            width: MediaQuery.of(context).size.width-50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(child: Icon(Icons.alarm, color: Colors.black,),onTap: (){setState(){whichActionSelected = 1;}},),
                SizedBox(width: 20,),
                GestureDetector(child: Icon(Icons.watch_later_sharp, color: (whichActionSelected == 1)?Colors.black:Colors.grey;),onTap: (){setState(){whichActionSelected = 1;}},),
                SizedBox(width: 20,),
                GestureDetector(child: Icon(Icons.timer, color: (whichActionSelected == 1?Colors.black:Colors.grey;)),onTap: (){setState(){whichActionSelected = 3;}},),
                SizedBox(width: 20,),
                GestureDetector(child: Icon(Icons.hourglass_empty_sharp, color: (whichActionSelected == 1?Colors.black:Colors.grey;)),onTap: (){setState(){whichActionSelected = 4;}},),
              ],
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),
          ],
        ),
        // backgroundColor: Colors.black,
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index){
            return AlarmCard();
          },
        ),
      ),
    );
  }
}
