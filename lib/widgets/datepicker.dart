import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class datepicker extends StatefulWidget {
  const datepicker({Key? key}) : super(key: key);

  @override
  _datepickerState createState() => _datepickerState();
}

class _datepickerState extends State<datepicker> {
  late DateTime selectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text(selectedDate == DateTime.now() ? "Today" : "$selectedDate"),//Text("Show DatePicker"),
                  onPressed: () {
                    showDatePicker();
                  },
                ),
                //Text(selectedDate == null? "" : "$selectedDate")
              ],
            )
        )
    );
  }

  void showDatePicker() {
    showCupertinoModalPopup
      (
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height*0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                if (value != selectedDate)
                  setState(() {
                    selectedDate = value;
                  });
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2000,
              maximumYear: 2050,
            ),
          );
        }
    );
  }
}

