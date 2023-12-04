import 'package:flutter/material.dart';
import 'screens/static_screen.dart';

void main() {
  runApp(const Mypp());
}

class Mypp extends StatelessWidget {
  const Mypp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: AlarmScreen(),
    );
  }
}
