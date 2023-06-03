import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({Key key}) : super(key: key);

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  String _timezone = 'Unknown';
  List<String> _availableTimezones = <String>[];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      _timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }
    try {
      _availableTimezones = await FlutterNativeTimezone.getAvailableTimezones();
      _availableTimezones.sort();
    } catch (e) {
      print('Could not get available timezones');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Column(
            children: [
              Text("Select City"),
              Text(
                "Time zones",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
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
                onTap: () {
                  print("Hehehe");
                },
              ),
            ),
            Text('Local timezone: $_timezone\n'),
            Text('Available timezones:'),
            Expanded(
              child: AlphabetScrollView(
                list: _availableTimezones.map((e) => AlphaModel(e)).toList(),
                // isAlphabetsFiltered: false,
                alignment: LetterAlignment.right,
                itemExtent: 50,
                unselectedTextStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                selectedTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
                // overlayWidget: (value) => Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     Icon(
                //       Icons.star,
                //       size: 50,
                //       color: Colors.red,
                //     ),
                //     Container(
                //       height: 50,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         // color: Theme.of(context).primaryColor,
                //       ),
                //       alignment: Alignment.center,
                //       child: Text(
                //         '$value'.toUpperCase(),
                //         style: TextStyle(fontSize: 18, color: Colors.white),
                //       ),
                //     ),
                //   ],
                // ),
                itemBuilder: (_, k, id) {
                  List<String> res = _availableTimezones[k].split("/");
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ListTile(
                      title: Text(res.last),
                      // subtitle: Text("${res.first} GMT+5:00"),
                      subtitle: Text("${res.first}"),
                    ),
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
