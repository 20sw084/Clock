import 'package:flutter/material.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Column(
            children: [
              Text("Select City"),
              Text("Time zones",style: TextStyle(fontSize: 14,),),
            ],
          )),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for country or city",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onTap: (){print("Hehehe");},
              ),
            ),

          ],
        ),
      ),
    );
  }
}
