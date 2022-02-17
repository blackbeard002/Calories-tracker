import 'package:flutter/material.dart';
import 'dart:ui';

class datePicker extends StatefulWidget {
  const datePicker({Key key}) : super(key: key);

  @override
  _datePickerState createState() => _datePickerState();
}
class _datePickerState extends State<datePicker> {

  @override
  void initState()
  {
    setState(() {
    });
  }

  DateTime _dateTime = DateTime.now();
  DateTime _today = DateTime.now();
  String _datePicked = 'Today';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime(2021),
                lastDate: DateTime.now(),
                currentDate: DateTime.now(),
                builder: (BuildContext context, Widget child)
                {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Colors.orange,
                      ),
                    ),
                    child: child,
                  );
                },
              ).then((date){
                setState(() {
                  _dateTime = date;
                  if(date.day == _today.day && date.year == _today.year && date.month == _today.month)
                  {
                    _datePicked = 'Today';
                  }
                  else{
                    _datePicked = date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString() + "  " + getDay(date.weekday);
                  }
                });
              }
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0.0,
            ),
            label: Text(_datePicked,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0.0,0.0),
                      color: Colors.grey,
                      blurRadius: 6.0,
                    )
                  ]
              ),
            ),
            icon: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  String getDay(int i){
    print(_dateTime);
    print(_today);
    switch(i)
    {
      case 1:{
        return 'Monday';
      }
      case 2:{
        return 'Tuesday';
      }
      case 3:{
        return 'Wednesday';
      }
      case 4:{
        return 'Thursday';
      }
      case 5:{
        return 'Friday';
      }
      case 6:{
        return 'Saturday';
      }
      case 7:{
        return 'Sunday';
      }
    }
  }
}
