import 'package:calories_tracker/widgets/circle_display.dart';
import 'package:flutter/material.dart';
import 'package:calories_tracker/widgets/scrolling_list_picker.dart';

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
  final ValueNotifier <List<String>> _weightUnit = ValueNotifier(['100','Gm']);
  String? foodName;
  String? foodImageUrl;
  List? defaultWeights;
  List? defaultUnits;
  void dbConnection()
  {
    //database code goes here B)

    //just setting some dummy values to make widget work #ignore
    foodName = widget.foodName;
    foodImageUrl = 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=louis-hansel-onxjrr3Erwc-unsplash.jpg&w=1920';
    defaultWeights = [100,200,350,400,500];
    defaultUnits = ['Gm', 'Oz'];
  }

  @override
  void initState() {

    super.initState();
    //calls DB connection
    //set all values in dbConnection
    dbConnection();
    setState(() {});
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
                      foodName ?? 'name not found',
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
    double weight = double.parse(s[0]);
    String unit = s[1];
    double carb, protein, fats, fibre;

    //doo math here

    //setting dummy values for now
    carb = weight - 10.0;
    fats = weight - 35.0;
    protein = weight - 25.0;
    fibre = weight - 15.0;
    List<String> returnList;

    //data list indexes
    //[0] : carbs macro value
    //[1] : fats macro value
    //[2] : protein macro value
    //[3] : fibre macro value

    return returnList = ['$carb','$fats','$protein', '$fibre'];
  }
}

