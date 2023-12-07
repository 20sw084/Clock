import 'package:alarm_app/providers/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/static_screen.dart';

void main() {
  runApp(const Mypp());
}

class Mypp extends StatelessWidget {
  const Mypp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimeModel(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AlarmScreen(),
        ),
    );
  }
}
