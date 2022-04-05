import 'package:calories_tracker/pages/add_food.dart';
import 'package:calories_tracker/widgets/hero_dialogue_route.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

typedef InsertFood<T> = void Function(List<String>);

class searchfood extends StatefulWidget {
  DateTime selectedDate;
  searchfood({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _searchfoodState createState() => _searchfoodState();
}

class _searchfoodState extends State<searchfood> with SingleTickerProviderStateMixin{

  //db call variables
  var food="",res,fname="";
  var conn;

  //anim variables
  double _width = 0.0;
  double _height = 0.0;
  double _radius = 360;

  //text edit variables
  late FocusNode searchBox;
  late TextEditingController searchControl;

  //food tracking variables
  List<List<String>> foodReturns = [];
  @override
  void initState() {
    super.initState();
    getConn();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scaleSearch();
    });
    searchBox = FocusNode();
    searchControl = new TextEditingController();
  }

  void scaleSearch(){
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = 150;
      _radius = 00;
    });
  }
  @override
  void dispose() {
    super.dispose();
    conn.close();
  }

  @override
  Widget build(BuildContext context) {
    void query() async {
      res=await conn.query('select FOOD from MACROS where food=?',[food]);
      fname=res.toString();
      fname=fname.substring(16,16+food.length);
      fname=fname.toLowerCase();
      if(fname==food) {setState(() {});}
    }

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: <Widget> [
                AnimatedContainer(
                  width: _width,
                  height: _height,
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: Colors.purple[400],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(_radius)
                      )
                  ),
                  onEnd: (){
                    searchBox.requestFocus();
                  },
                  curve: Curves.easeIn,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: searchControl,
                            focusNode: searchBox,
                            cursorColor: Colors.white,
                            autocorrect: false,
                            enableSuggestions: false,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),
                            autofocus: false,
                            onChanged: (val)
                            {
                              //print(widget.selectedDate);
                              setState(() {
                                food=val;
                                query();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.fastfood_sharp, color: Colors.white, size: 30,),
                              hintText: 'enter food name ..',
                              hintStyle: TextStyle(
                                  color: Colors.white24,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          ),
                          SizedBox(height: 2,),



                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(foodReturns.length, (index) => Chipper(
                                name: foodReturns[index][0],
                                weight: foodReturns[index][1],
                              ))
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 0.0),
                    child: Container(
                      child: Column(
                          children: [
                            if(fname==food && fname!='')
                              suggestion(
                                foodName: fname,
                                selectedDate: widget.selectedDate,
                                insertFood: (List<String> f){
                                  foodReturns.add(f);
                                  setState(() {});
                                },
                              )
                          ]
                      ),
                    ),
                  ),
                ),
                WillPopScope(
                  child: Text(''),
                  onWillPop: animateSearchBack,
                ),
              ]
          ),
        ),
      ),
    );
  }
  Future<bool> animateSearchBack() async
  {
    setState(() {
      _width = 0.0;
      _height = 0.0;
      print(foodReturns);
      //food access here
    });
    return true;
  }

  Future<void> getConn() async
  {
    var settings=new ConnectionSettings(
        host: "caloriestracker.cule8a3xeym9.ap-south-1.rds.amazonaws.com",
        port: 3306,
        user: 'admin',
        password: 'calories_o2',
        db: 'CALORIES_TRACKER'
    );
    conn= await MySqlConnection.connect(settings);
  }
}

class suggestion extends StatefulWidget {
  String foodName = '';
  InsertFood<List<String>> insertFood;
  DateTime selectedDate;
  suggestion({
    //suggestion variables
    Key? key,
    required this.foodName,
    required this.selectedDate,
    required this.insertFood,
  }) : super(key: key);

  @override
  _suggestionState createState() => _suggestionState();
}
class _suggestionState extends State<suggestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          )
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 7.0, 5.0, 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [


            Expanded(
              flex: 9,
              child: Text(
                widget.foodName.toUpperCase(),
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
            ),


            Expanded(
              flex: 1,
              child: Hero(
                  tag: 'quantity',
                  child: GestureDetector(
                    onTap: ()async{
                      addFoodMenu();
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
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ),
            ),


            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void addFoodMenu() async{
    final result = await Navigator.of(context).push(HeroDialogRoute(
      // moving to add_food carrying only food name
        builder: (context){return addfood(foodName: widget.foodName, selectedDate: widget.selectedDate,);},
        settings: RouteSettings())
    );
    widget.insertFood(result);
  }

}


class Chipper extends StatefulWidget {
  String name;
  String weight;
  Chipper({
    required this.name,
    required this.weight,
    Key? key
  }) : super(key: key);

  @override
  _ChipperState createState() => _ChipperState();
}

class _ChipperState extends State<Chipper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Chip(
        label: Text(widget.name + ' ' + widget.weight),
        //delete functionality here
        onDeleted: (){},
      ),
    );
  }
}
