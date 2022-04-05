import 'package:calories_tracker/widgets/circle_display.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/scrolling_list_picker.dart';
import 'package:mysql1/mysql1.dart';

class addfood extends StatefulWidget {
  String foodName;
  DateTime selectedDate;
  addfood({
    Key? key,
    required this.foodName,
    required this.selectedDate
  }) : super(key: key);

  @override
  _addfoodState createState() => _addfoodState();
}

class _addfoodState extends State<addfood> {
  //ignore
  final ValueNotifier <List<String>> _weightUnit = ValueNotifier(['100','grams']);

  List<String> foodRets = ['0','0','0','0','0','0','0','0'];
  String? foodName;
  String? foodImageUrl;
  List? defaultWeights;
  List? defaultUnits;

  double carb=0,fat=0,protein=0,fibres=0,calo=0;
  void dbconnection() async {
    var settings=new ConnectionSettings(
        host: "caloriestracker.cule8a3xeym9.ap-south-1.rds.amazonaws.com",
        port: 3306,
        user: 'admin',
        password: 'calories_o2',
        db: 'CALORIES_TRACKER'
    );
    var conn= await MySqlConnection.connect(settings);

    var res=await conn.query('select * from MACROS where food=?',[foodName]);
    await conn.close();
    for(var row in res)
      {
        calo=row[1];
        fat=row[2];
        carb=row[3];
        protein=row[4];
        fibres=row[5];
      }
    setState(() {

    });
  }

  @override
  void initState() {

    super.initState();
    defaultWeights = [100,200,350,400,500];
    defaultUnits = ['gm', 'oz'];
    foodName = widget.foodName;
    foodImageUrl = 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=louis-hansel-onxjrr3Erwc-unsplash.jpg&w=1920';
    foodRets[0] = widget.foodName;
    dbconnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'quantity',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 80, 32, 90),
          child: Material(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)
                        ),
                        child: Image.network(
                          foodImageUrl ?? '',
                          fit: BoxFit.fill,
                          scale: 1.0,
                        ),
                      ),
                      Positioned(
                        child: Text(widget.foodName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 4,
                              offset: Offset.fromDirection(1),
                            )
                          ]
                        ),),
                        bottom: 10,
                        left: 10,
                      )
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      listPicker(
                        heading: 'Pick Quantity',
                        isInput: true,
                        scrollList: defaultWeights ?? ['df','df'],
                        budColor: Colors.orange,
                        textColor: Colors.black,
                        onChange: (val) {
                          _weightUnit.value[0] = val;

                          foodRets[1] = val.toString();

                          _weightUnit.notifyListeners();
                        },
                      ),
                      SizedBox(width: 20,),
                      listPicker(
                        heading: 'Pick unit',
                        isInput: false,
                        scrollList: defaultUnits ?? ['df','df'],
                        budColor: Colors.purple,
                        onChange: (val) {
                          _weightUnit.value[1] = val;

                          foodRets[2] = val.toString();

                          _weightUnit.notifyListeners();
                        },
                      ),
                    ],
                  ),



                  Divider(thickness: 2,),
                  SizedBox(height: 15,),
                  ValueListenableBuilder(
                      valueListenable: _weightUnit,
                      builder: (BuildContext context, List<String> value, Widget? child){
                        return macroDisplays(
                          data: calcMacros(value),
                          finishAdding: (){
                            foodRets[3] = '$_calories';
                            foodRets[4] = '$_carbs';
                            foodRets[5] = '$_fats';
                            foodRets[6] = '$_proteins';
                            foodRets[7] = '$_fibre';
                            Navigator.pop(context, foodRets);
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double? _carbs, _proteins, _fats, _fibre, _calories;
  List<String> calcMacros(List<String> s)
  {
    //weight and unit are set
    double? weight = double.parse(s[0]);
    String unit = s[1];


    //convert weight into grams
    (unit=="oz")?weight=weight*28.34:weight=weight;

    //calculating the constant
    weight=(weight/100);

    //calculating macros values
    _calories = double.parse((weight * calo).toStringAsFixed(0));
    _fats = double.parse((weight * fat).toStringAsFixed(1));
    _carbs = double.parse((weight * carb).toStringAsFixed(1));
    _proteins = double.parse((weight * protein).toStringAsFixed(1));
    _fibre = double.parse((weight * fibres).toStringAsFixed(1));
    List<String> returnList;

    //todo:display calories value in the UI
    //print("calories:$calories");

    return returnList = ['$_carbs','$_fats','$_proteins', '$_fibre', '$_calories'];
  }
}

