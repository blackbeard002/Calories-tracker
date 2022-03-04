import 'package:calories_tracker/widgets/water.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:calories_tracker/widgets/indicators.dart';
import 'package:calories_tracker/widgets/session_widget.dart';
import 'package:calories_tracker/widgets/user_info.dart';
import 'package:flutter/services.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late  SnackBar exitConfirm;
  sessionTracker _session = sessionTracker(
    //default vars, consider this the initialization function
    //dump the vars you need for setting initial values here
    //declare the variables you need in session_widget.dart and initialize them in constructor
    //here is where you set the default values from user to reflect UI

    //for now this class only tracks Date var between widgets

    selectedDate: DateTime.now(),
  );

  void printTest(){print(_session.selectedDate.toString());}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    exitConfirm = SnackBar(
      content: Text('Are you sure exit?'),
      action: SnackBarAction(
        label: 'Yes',
        onPressed: (){
          SystemNavigator.pop(animated: true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent
                ],
                stops: [0.0, 0.4]
            )
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedContainer(
                        alignment: Alignment.center,
                        duration: Duration(seconds: 5),
                        child: SizedBox(height: 200, width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: userInfo(),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 69/100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                              child: heatMapInvoker(session_: _session),
                            ),
                            indicators(
                              calsTotal: 3000,
                              calsConsumed: 1045,
                              carbsPercent: 35,
                              fatsPercent: 56,
                              proteinPercent: 66,
                              fibrePercent: 56,
                              primaryColor: Colors.purple[400],
                            ),
                            water(
                              waterConsumed: 40,
                              primaryColor: Colors.purple[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  WillPopScope(
                    child: Text(''),
                    onWillPop: closeApp,
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  Future<bool> closeApp() async
  {
    ScaffoldMessenger.of(context).showSnackBar(exitConfirm);
    return false;
  }
}

