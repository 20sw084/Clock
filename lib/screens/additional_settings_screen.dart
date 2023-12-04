import 'package:flutter/material.dart';

import '../scroll_button_screen.dart';

class AdditionalSettingsScreen extends StatefulWidget {
  const AdditionalSettingsScreen({super.key});

  @override
  State<AdditionalSettingsScreen> createState() => _AdditionalSettingsScreenState();
}

class _AdditionalSettingsScreenState extends State<AdditionalSettingsScreen> {
  bool stateOfButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.done,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.not_interested_rounded),
          onPressed: null,
        ),
        title: Center(
          child: Column(
            children: [
              Text("Edit Alarm"),
              Text(
                "Off",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Scrollable buttons for AM/PM, Hours (01-12), Minutes (00-59)
                ScrollButton(items: ['AM', 'PM'], title: 'AM/PM'),
                VerticalDivider(),
                ScrollButton(
                    items: List.generate(12, (index) => '${index + 1}'),
                    title: 'Hours'),
                VerticalDivider(),
                ScrollButton(
                    items: List.generate(
                        60, (index) => '${index.toString().padLeft(2, '0')}'),
                    title: 'Minutes'),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50,
            child: ListTile(
              title: Text("Ringtone"),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Default Ringtone"),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              title: Text("Repeat"),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Monday to Friday"),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              title: Text("Vibrate when alarm sounds"),
              trailing: Transform.scale(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              child: GestureDetector(
                child: ListTile(
                  title: Text("Label"),
                  trailing: Text("Enter Label"),
                ),
                onTap: (){
                  _showInputDialog(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    TextEditingController _textController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.bottomRight,
          title: Text('Add Alarm Label'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter Label',
                  hintText: 'Label hint text',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button action
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // OK button action, you can use _textController.text to get the input
                print('Entered Label: ${_textController.text}');
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
