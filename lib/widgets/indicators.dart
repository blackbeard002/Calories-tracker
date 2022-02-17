import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dart:math';

class indicators extends StatefulWidget {

  //for text of widgets
  int calsTotal;
  int calsConsumed;
  double fibrePercent;
  double fatsPercent;
  double carbsPercent;
  double proteinPercent;
  indicators({Key key,
    final this.calsConsumed,
    final this.calsTotal,
    this.carbsPercent,
    this.fatsPercent,
    this.fibrePercent,
    this.proteinPercent,
  }) : super(key: key);

  @override
  _indicatorsState createState() => _indicatorsState();
}

class _indicatorsState extends State<indicators> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 3.0,
        color: Colors.white,
        shadowColor: Colors.redAccent,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: new CircularPercentIndicator(
                      radius: 49.0,
                      animation: true,
                      animationDuration: 400,
                      backgroundColor: Colors.grey[350],
                      progressColor: Colors.redAccent,
                      lineWidth: 10.0,
                      center: Text(
                        widget.calsConsumed.toString() + '/' + widget.calsTotal.toString() ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //reconnect to widget.calPercent
                      percent: getPercent(widget.calsConsumed.toDouble(), widget.calsTotal.toDouble()),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Cals Consumed',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17.0,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0,1.0),
                              color: Colors.grey[850],
                              blurRadius: 2.0,
                            )
                          ]
                      ),
                    ),

                  ),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Colors.redAccent
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: new LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: widget.carbsPercent/100,
                      center: Text(widget.carbsPercent.toString() + "%  " + 'Carbs'),
                      barRadius: Radius.circular(20),
                      progressColor: Colors.redAccent,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: new LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: widget.fatsPercent/100,
                      center: Text(widget.fatsPercent.toString() + "%  " + 'Fats'),
                      barRadius: Radius.circular(20),
                      progressColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: new LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: widget.proteinPercent/100,
                      center: Text(widget.proteinPercent.toString() + "%  " + 'Protein'),
                      barRadius: Radius.circular(20),
                      progressColor: Colors.redAccent,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: new LinearPercentIndicator(
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 400,
                      percent: widget.fibrePercent/100,
                      center: Text(widget.fibrePercent.toString() + "%  " + 'Fibre'),
                      barRadius: Radius.circular(20),
                      progressColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,)
          ],
        ),
      ),
    );
  }

  double getPercent(double c, double t)
  {
    return ((c/t)*10)/10;
  }
}
