import 'package:calories_tracker/pages/add_food.dart';
import 'package:calories_tracker/widgets/hero_dialogue_route.dart';
import 'package:calories_tracker/widgets/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class searchfood extends StatefulWidget {
  const searchfood({Key? key}) : super(key: key);

  @override
  _searchfoodState createState() => _searchfoodState();
}

class _searchfoodState extends State<searchfood> {
  var food="",res,fname="";
  sessionTracker sessionT = sessionTracker();
  @override
  Widget build(BuildContext context) {
    void dbconnection() async {
      var settings=new ConnectionSettings(
          host: "caloriestracker.cule8a3xeym9.ap-south-1.rds.amazonaws.com",
          port: 3306,
          user: 'admin',
          password: 'calories_o2',
          db: 'CALORIES_TRACKER'
      );
      var conn= await MySqlConnection.connect(settings);

      res=await conn.query('select FOOD from MACROS where food=?',[food]);
      fname=res.toString();
      fname=fname.substring(16,16+food.length);
      fname=fname.toLowerCase();
      conn.close();
      if(fname==food)
      {
        setState(() {});
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SEARCH FOODS"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      body: Column(
          children: <Widget> [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:  TextField(
                  onChanged: (val)
                  {
                    setState(() {
                      food=val;
                      dbconnection();
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.fastfood),
                    fillColor: Colors.orange,
                    focusColor: Colors.orange,
                    hintText: 'Enter food ',
                    hintStyle: TextStyle(
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 0.0),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: [
                      if(fname==food && fname!='')
                        suggestion(foodName: fname,)
                    ]
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}


class suggestion extends StatefulWidget {
  String foodName = '';
  suggestion({
    //suggestion variables
    Key? key,
    required this.foodName

  }) : super(key: key);

  @override
  _suggestionState createState() => _suggestionState();
}
class _suggestionState extends State<suggestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  widget.foodName,
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Hero(
                  tag: 'quantity',
                  child: TextButton(
                    onPressed: (){
                      Navigator.of(context).push(HeroDialogRoute(
                          // moving to add_food carrying only food name
                          builder: (context){return addfood(foodName: widget.foodName,);},
                          settings: RouteSettings())
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: TextButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.orange[800],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
