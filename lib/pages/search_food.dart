import 'package:calories_tracker/pages/add_food.dart';
import 'package:calories_tracker/widgets/hero_dialogue_route.dart';
import 'package:calories_tracker/widgets/session_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';

class searchfood extends StatefulWidget {
  const searchfood({Key? key}) : super(key: key);

  @override
  _searchfoodState createState() => _searchfoodState();
}

class _searchfoodState extends State<searchfood> with SingleTickerProviderStateMixin{
  var food="",res,fname="";
  double _width = 0.0;
  double _height = 0.0;
  double _radius = 360;
  late FocusNode searchBox;
  late TextEditingController searchControl;
  sessionTracker sessionT = sessionTracker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      _radius = 50;
    });
  }

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
                              setState(() {
                                food=val;
                                dbconnection();
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
                          Chip(onDeleted: (){}, backgroundColor: Colors.white, label: Text('Egg'),),
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
                              suggestion(foodName: fname,)
                          ]
                      ),
                    ),
                  ),
                ),
                WillPopScope(
                  child: Text('hello'),
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
    });
    return true;
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
                    onTap: (){
                      Navigator.of(context).push(HeroDialogRoute(
                        // moving to add_food carrying only food name
                          builder: (context){return addfood(foodName: widget.foodName,);},
                          settings: RouteSettings())
                      );
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
}
