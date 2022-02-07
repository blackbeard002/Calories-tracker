import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/datepicker.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calories Tracker"),
        ),
        body: datepicker(),
    );
  }
}

