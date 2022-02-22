import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class water extends StatefulWidget {
  double waterConsumed;
  Color primaryColor;
  water({
    Key key,
    this.waterConsumed,
    this.primaryColor
  }) : super(key: key);

  @override
  _waterState createState() => _waterState();
}

class _waterState extends State<water> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Material(
          elevation: 2.0,
          color: Colors.white,
          shadowColor: Colors.grey,
          borderRadius: BorderRadius.circular(32.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: new CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 7.0,
                    animation: true,
                    animationDuration: 400,
                    percent: widget.waterConsumed/100,
                    backgroundColor: Colors.grey[350],
                    progressColor: widget.primaryColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Icon(
                      Icons.emoji_food_beverage,
                      color: Colors.grey[850],
                    ),

                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Text(
                    'Water Consumed',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: widget.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
