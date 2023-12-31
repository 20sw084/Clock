import 'package:flutter/cupertino.dart';

class ScrollButton extends StatefulWidget {
  final List<String> items;
  final String title;
  final Function(String) onValueChanged;

  const ScrollButton({required this.items, required this.title, required this.onValueChanged});

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
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.2,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedValue = widget.items[index];
              });
              widget.onValueChanged(selectedValue); // Invoke the callback here
            },
            children: List<Widget>.generate(widget.items.length, (int index) {
              return Center(
                child: Text(widget.items[index]),
              );
            }),
          ),
        ),
      ],
    );
  }
}
