import 'dart:math';
import 'package:calories_tracker/widgets/water.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/heatMapInvoker.dart';
import 'package:calories_tracker/widgets/indicators.dart';
import 'package:calories_tracker/widgets/user_info.dart';
import 'package:flutter/services.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  late  SnackBar exitConfirm;
  final ValueNotifier<int> rebuildInd = ValueNotifier(2);
  Random rng = Random(23);
  DateTime currentDate = DateTime.now();

  //indicator variables
  int? totalCals, calsConsumed;
  double? carbs, fats, proteins, fibre;
  int defaultInt = 300;
  double defaultDouble = 34;

  @override
  void initState() {
    super.initState();
    updateHome();
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
        height: MediaQuery.of(context).size.height,
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
                              child: heatMapInvoker(
                                updateDate: (newDate)
                                {setState(() {currentDate = newDate; print(currentDate); rebuildInd.value = rng.nextInt(10);  updateHome();});},
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: rebuildInd,
                              builder: (BuildContext context, int val, Widget? child){
                                return indicators(
                                  selectedDate: currentDate,
                                  calsTotal: totalCals ?? defaultInt,
                                  calsConsumed: calsConsumed ?? defaultInt,
                                  carbsPercent: carbs ?? defaultDouble,
                                  fatsPercent:fats ?? defaultDouble,
                                  proteinPercent: proteins ?? defaultDouble,
                                  fibrePercent: fibre ?? defaultDouble,
                                  primaryColor: Colors.purple[400],
                                  rebuildHome: () {
                                    updateHome();
                                  },
                                );
                              }
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

  Future<void> updateHome() async
  {
    // feeding dummy data for now below
    // ignore and delete after adding database code here
    // todo: do database tomfuckery here
    // set values to these variables like before

    calsConsumed = rng.nextInt(2000);
    totalCals = 3000;
    fats = 20; carbs = 25; fibre = 25; proteins = 35;



    
    // leave this next line alone
    // it is responsible for updating the widget
    //always should be called last
    rebuildInd.value = rng.nextInt(34);
  }
}

