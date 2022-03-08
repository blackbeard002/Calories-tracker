import 'package:calories_tracker/widgets/circle_display.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/scrolling_list_picker.dart';
import 'package:mysql1/mysql1.dart';

class addfood extends StatefulWidget {
  String foodName;
  addfood({
    Key? key,
    required this.foodName,
  }) : super(key: key);

  @override
  _addfoodState createState() => _addfoodState();
}

class _addfoodState extends State<addfood> {
  //ignore
  final ValueNotifier <List<String>> _weightUnit = ValueNotifier(['100','grams']);
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
    defaultUnits = ['grams', 'oz'];
    foodName = widget.foodName;
    foodImageUrl = 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=louis-hansel-onxjrr3Erwc-unsplash.jpg&w=1920';
    dbconnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'quantity',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 80, 32, 80),
          child: Material(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 15.0),
                    child: Text(
                      widget.foodName,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Image.network(
                    foodImageUrl ?? '',
                    fit: BoxFit.fill,
                  ),

                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      listPicker(
                        isInput: true,
                        scrollList: defaultWeights ?? ['df','df'],
                        budColor: Colors.orange,
                        textColor: Colors.black,
                        onChange: (val) {
                          _weightUnit.value[0] = val;
                          _weightUnit.notifyListeners();
                        },
                      ),
                      listPicker(
                        isInput: false,
                        scrollList: defaultUnits ?? ['df','df'],
                        budColor: Colors.orange,
                        onChange: (val) {
                          _weightUnit.value[1] = val;
                          _weightUnit.notifyListeners();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  ValueListenableBuilder(
                      valueListenable: _weightUnit,
                      builder: (BuildContext context, List<String> value, Widget? child){
                        return macroDisplays(
                          data: calcMacros(value),
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

  List<String> calcMacros(List<String> s)
  {

    //weight and unit are set
    double? weight = double.parse(s[0]);
    String unit = s[1];
    double? carbs, proteins, fats, fibre,calories;

    //convert weight into grams
    (unit=="oz")?weight=weight*28.34:weight=weight;

    //calculating the constant
    weight=(weight/100);

    //calculating macros values
    calories = double.parse((weight * calo).toStringAsFixed(0));
    fats = double.parse((weight * fat).toStringAsFixed(1));
    carbs = double.parse((weight * carb).toStringAsFixed(1));
    proteins = double.parse((weight * protein).toStringAsFixed(1));
    fibre = double.parse((weight * fibres).toStringAsFixed(1));
    List<String> returnList;

    //todo:display calories value in the UI
    print("calories:$calories");

    return returnList = ['$carbs','$fats','$proteins', '$fibre'];

  }
}

