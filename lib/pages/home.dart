import 'package:calories_tracker/widgets/water.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:calories_tracker/widgets/indicators.dart';
import 'package:calories_tracker/widgets/cross_widget_vars.dart';

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {


  crossWidgetVars _transporter = crossWidgetVars(
    //default vars, consider this the initialization funciton
    //dump the vars you need for setting initial values here
    //declare the variables you need in cross_widget_vars.dart and initialize them in constructor
    //here is where you set the default values from user to reflect UI

    //for now this class only tracks Date var between widgets
    selectedDate: DateTime.now(),

  );

  void printTest(){print(_transporter.selectedDate.toString());}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: heatMapInvoker(
            transporter: _transporter,
          ),
          centerTitle: false,
        ),

        body:
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: SafeArea(
            child: Column(
              children: [
                indicators(
                  calsTotal: 3000,
                  calsConsumed: 950,
                  carbsPercent: 80.21,
                  fatsPercent: 40.0,
                  fibrePercent: 30.0,
                  proteinPercent: 25.0,
                  primaryColor: Colors.orange[800],
                ),

                //widget 3
                water(
                  waterConsumed: 70,
                  primaryColor: Colors.orange[800],
                ),

                /*ElevatedButton(
                  onPressed: (){
                    printTest();
                  },
                ),*/

              ],
            ),
          ),
        )
    );
  }
}

