import 'package:flutter/material.dart';

typedef FinishAdding<T> = void Function();

class macroDisplays extends StatefulWidget {
  List<String> data;
  FinishAdding<void> finishAdding;
  macroDisplays({
    Key? key,
    required this.finishAdding,
    required this.data,
  }) : super(key: key);

  @override
  _macroDisplaysState createState() => _macroDisplaysState();
}

class _macroDisplaysState extends State<macroDisplays> {
  double _width = 64.0;
  double _height = 64.0;

  //data list indexes
  //[0] : carbs macro value
  //[1] : fats macro value
  //[2] : protein macro value
  //[3] : fibre macro value

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0,8.0, 0.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Carbs',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.fastfood_rounded,color: Colors.white,),
                        Text(
                          widget.data[0], //data to show goes here
                          style: TextStyle(color: Colors.white,),
                        )],),
                  ),
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Fats',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.fastfood_rounded,color: Colors.white,),
                        Text(
                          widget.data[1], //data to show goes here
                          style: TextStyle(color: Colors.white,),
                        )],),
                  ),
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Protein',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.fastfood_rounded,color: Colors.white,),
                        Text(
                          widget.data[2], //data to show goes here
                          style: TextStyle(color: Colors.white,),
                        )],),
                  ),
                ],
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Fibre',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  SizedBox(height: 7,),
                  Container(
                    width: _width,
                    height: _height,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.fastfood_rounded,color: Colors.white,),
                        Text(
                          widget.data[3], //data to show goes here
                          style: TextStyle(color: Colors.white,),
                        )],),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Approx: ' + widget.data[4] + ' cals',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: (){
                  widget.finishAdding();
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(32))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text('Add Item',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      Icon(Icons.done,
                      color: Colors.white,)
                    ],),
                  )
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
