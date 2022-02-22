import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:calories_tracker/widgets/hero-dialogue-route.dart';
import 'package:calories_tracker/widgets/custom-rect-tween.dart';
import 'package:calories_tracker/pages/search_food.dart';

class indicators extends StatefulWidget {

  //for text of widgets
  int calsTotal;
  int calsConsumed;
  double fibrePercent;
  double fatsPercent;
  double carbsPercent;
  double proteinPercent;
  Color primaryColor;
  indicators({Key key,
    final this.calsConsumed,
    final this.calsTotal,
    this.carbsPercent,
    this.fatsPercent,
    this.fibrePercent,
    this.proteinPercent,
    this.primaryColor,
  }) : super(key: key);

  @override
  _indicatorsState createState() => _indicatorsState();
}

class _indicatorsState extends State<indicators> {
  double _lineWidth_circ = 7.0;
  double _lineWidth_line = 10.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(32.0),
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
                      radius: 30.0,
                      animation: true,
                      animationDuration: 400,
                      backgroundColor: Colors.grey[350],
                      progressColor: widget.primaryColor,
                      lineWidth: _lineWidth_circ,
                      center: Icon(
                        Icons.fork_left,
                        size: 30.0,
                      ),
                      //reconnect to widget.calPercent
                      percent: getPercent(widget.calsConsumed.toDouble(), widget.calsTotal.toDouble()),
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'Cals Consumed',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                      ),
                    ),

                  ),
                  Expanded(
                    flex: 5,
                    child: Hero(
                      tag: 'hero-search-test',
                      createRectTween: (begin, end){
                        return CustomRectTween(begin: begin, end: end);
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                            return const searchfood();}));
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: widget.primaryColor
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text(widget.carbsPercent.toString() + "%  " + 'Carbs',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        new LinearPercentIndicator(
                          animation: true,
                          lineHeight: _lineWidth_line,
                          animationDuration: 400,
                          percent: widget.carbsPercent/100,
                          barRadius: Radius.circular(20),
                          progressColor: widget.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text(widget.fatsPercent.toString() + "%  " + 'Fats',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        new LinearPercentIndicator(
                          animation: true,
                          lineHeight: _lineWidth_line,
                          animationDuration: 400,
                          percent: widget.fatsPercent/100,
                          barRadius: Radius.circular(20),
                          progressColor: widget.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text(widget.proteinPercent.toString() + "%  " + 'Protein',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        new LinearPercentIndicator(
                          animation: true,
                          lineHeight: _lineWidth_line,
                          animationDuration: 400,
                          percent: widget.proteinPercent/100,
                          barRadius: Radius.circular(20),
                          progressColor: widget.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Text(widget.fibrePercent.toString() + "%  " + 'Fibre',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        new LinearPercentIndicator(
                          animation: true,
                          lineHeight: _lineWidth_line,
                          animationDuration: 400,
                          percent: widget.fibrePercent/100,
                          barRadius: Radius.circular(20),
                          progressColor: widget.primaryColor,
                        ),
                      ],
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
