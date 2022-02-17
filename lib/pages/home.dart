import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/datePicker.dart';
import 'package:calories_tracker/widgets/indicators.dart';
import 'package:calories_tracker/widgets/water.dart';

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,

        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            'CALORIE',
            style: TextStyle(
                letterSpacing: 3.0,
                color: Colors.orange,
                shadows: [
                  Shadow(
                    offset: Offset(-1.0,1.0),
                    color: Colors.grey[850],
                    blurRadius: 2.0,
                  ),
                ]
            ),
          ),
          centerTitle: true,
        ),

        body:
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SafeArea(
            child: Column(
              children: [

                //widget 1
                datePicker(),

                //widget 2
                indicators(
                  calsTotal: 3000,
                  calsConsumed: 950,
                  carbsPercent: 80.21,
                  fatsPercent: 40.0,
                  fibrePercent: 30.0,
                  proteinPercent: 25.0,
                ),

                //widget 3
                water(
                  waterConsumed: 70.0,
                ),
                //out new custon super cool dick widget
              ],
            ),
          ),
        )
    );
  }
}

