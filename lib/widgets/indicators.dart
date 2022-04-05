import 'package:calories_tracker/pages/search_food.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:calories_tracker/widgets/hero_dialogue_route.dart';

typedef RebuildHome<T> = void Function();

class indicators extends StatefulWidget {
  //for text of widgets
  int calsTotal;
  int calsConsumed;
  double fibrePercent;
  double fatsPercent;
  double carbsPercent;
  double proteinPercent;
  DateTime selectedDate;
  RebuildHome<void> rebuildHome;
  Color? primaryColor;
  indicators({Key? key,
    required this.calsConsumed,
    required this.calsTotal,
    required this.carbsPercent,
    required this.fatsPercent,
    required this.fibrePercent,
    required this.proteinPercent,
    required this.selectedDate,
    required this.rebuildHome,
    required this.primaryColor,
  }) : super(key: key);

  @override
  _indicatorsState createState() => _indicatorsState();
}

class _indicatorsState extends State<indicators> {
  double _lineWidth_circ = 7.0;
  double _lineWidth_line = 10.0;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //print(widget.selectedDate);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(32)),
          boxShadow: [
            BoxShadow(
                offset: Offset.zero,
                color: Colors.grey,
                spreadRadius: 1.0,
                blurRadius: 9.0
            ),
          ]
      ),
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
                    backgroundColor: Colors.grey,
                    progressColor: widget.primaryColor,
                    lineWidth: _lineWidth_circ,
                    center: Icon(
                      Icons.favorite,
                      size: 26.0,
                    ),
                    //reconnect to widget.calPercent
                    percent: getPercent(widget.calsConsumed.toDouble(), widget.calsTotal.toDouble()),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.calsConsumed.toString() + '/' + widget.calsTotal.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text(
                          'Cals Consumed',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    )

                ),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamed('/edit');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.purpleAccent, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.7],
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.bar_chart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                         searchAdd(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.purpleAccent, Colors.purple],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.7],
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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
                      SizedBox(height: 3.0,),
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
                      SizedBox(height: 3.0,),
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
                      SizedBox(height: 3.0,),
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
                      SizedBox(height: 3.0,),
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
    );
  }

  double getPercent(double c, double t)
  {
    return ((c/t)*10)/10;
  }

  void searchAdd(BuildContext context) async{
    final value = await Navigator.of(context).push(HeroDialogRoute(
        builder: (context){
          return searchfood(selectedDate: widget.selectedDate,);
        }, settings: RouteSettings()));
    widget.rebuildHome();
  }
}
