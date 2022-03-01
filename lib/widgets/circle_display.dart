
import 'package:flutter/material.dart';

class macroDisplays extends StatefulWidget {
  List<String> data;
  macroDisplays({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _macroDisplaysState createState() => _macroDisplaysState();
}

class _macroDisplaysState extends State<macroDisplays> {
  double _width = 60.0;
  double _height = 60.0;

  //data list indexes
  //[0] : carbs macro value
  //[1] : fats macro value
  //[2] : protein macro value
  //[3] : fibre macro value

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0,8.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.fastfood_rounded,color: Colors.white,),
                Text(
                  widget.data[0], //data to show goes here
                  style: TextStyle(color: Colors.white,),
                )],),
          ),


          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.fastfood_rounded,color: Colors.white,),
                Text(
                  widget.data[1], //data to show goes here
                  style: TextStyle(color: Colors.white,),
                )],),
          ),


          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.fastfood_rounded,color: Colors.white,),
                Text(
                  widget.data[2], //data to show goes here
                  style: TextStyle(color: Colors.white,),
                )],),
          ),


          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange),
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
    );
  }
}
