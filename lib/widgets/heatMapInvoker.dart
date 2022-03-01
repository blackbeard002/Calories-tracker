import 'package:calories_tracker/widgets/hero_dialogue_route.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:calories_tracker/widgets/session_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class heatMapInvoker extends StatefulWidget {
  sessionTracker session_;
  heatMapInvoker({Key? key, required this.session_}) : super(key: key);
  @override
  _heatMapInvokerState createState() => _heatMapInvokerState();
}

class _heatMapInvokerState extends State<heatMapInvoker> {

  //vars
  DateTime _dateThrownBack = DateTime.now();
  String _buttonText = 'Today';

  void getDateFromHeatmap(BuildContext context) async{
    _dateThrownBack = await Navigator.of(context).push(HeroDialogRoute(
      builder: (context){ return const heatmap();},
      settings: RouteSettings(),
    ));
    setState(() {

      //setting session variable selectedDate
      widget.session_.selectedDate = _dateThrownBack;
      _buttonText = generateButtonText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Hero(
            tag: 'show-calender',

            child: ElevatedButton.icon(
              onPressed: () {
                getDateFromHeatmap(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 0.0,
              ),
              label: Text(_buttonText,
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
          ),
        ],
      ),
    );
  }

  //nothing special, just doing some string operations for button text, ignore
  String generateButtonText()
  {
    String day = 'Sun';
    switch(_dateThrownBack.weekday)
    {
      case 1:{
        day = 'Mon';
        break;
      }
      case 2:{
        day = 'Tue';
        break;
      }
      case 3:{
        day = 'Wed';
        break;
      }
      case 4:{
        day = 'Thu';
        break;
      }
      case 5:{
        day = 'Fri';
        break;
      }
      case 6:{
        day = 'Sat';
        break;
      }
      case 7:{
        day = 'Sun';
        break;
      }
    }
    String temp = _dateThrownBack.day.toString() + " " + day;
    return temp;
  }

}

class heatmap extends StatefulWidget {
  const heatmap({Key? key}) : super(key: key);

  @override
  _heatmapState createState() => _heatmapState();
}

class _heatmapState extends State<heatmap> {

  void on_selectionChanged(DateRangePickerSelectionChangedArgs args) {
    //stuff to do when a different date is selected
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Hero(
          tag: 'show-calender',
          child: SingleChildScrollView(
            child:Material(
              color: Colors.white,
              elevation: 5.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(20.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 20.0, 6.0, 6.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        thickness: 1.0,
                        color: Colors.orange[800],
                      ),
                      SfDateRangePicker(
                        onSelectionChanged: on_selectionChanged,
                        selectionMode: DateRangePickerSelectionMode.single,
                        initialSelectedDate: DateTime.now(),
                        maxDate: DateTime.now(),
                        showActionButtons: true,
                        selectionColor: Colors.orange[800],
                        todayHighlightColor: Colors.orange[800],
                        onSubmit: (value) {
                          Navigator.pop(context,value);
                        }
                      ),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
