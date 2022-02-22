import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:calories_tracker/pages/add_food.dart';

class searchfood extends StatefulWidget {
  const searchfood({Key key}) : super(key: key);

  @override
  _searchfoodState createState() => _searchfoodState();
}

class _searchfoodState extends State<searchfood> {
  var food="",res,fname="";
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
      if(fname==food)
        {
          setState(() {

          });
        }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Calories Tracker"),
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
                  labelText: "Search food",
                ),
              ),
            ),
          ),
          Row(
            children: <Widget> [
              if(fname==food)
                  Text(fname),
              if(fname==food&&fname!="")
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () async {
                        dynamic result= await Navigator.pushNamed(context, "/addfood");
                      }
                  ),
            ],
          ),
        ]
      ),
    );
  }
}
