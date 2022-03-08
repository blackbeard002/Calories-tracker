import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class flashscreen extends StatefulWidget {
  const flashscreen({Key? key}) : super(key: key);

  @override
  _flashscreenState createState() => _flashscreenState();
}

class _flashscreenState extends State<flashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () async {
            if(await checkFirst.firstRun()){
              Navigator.of(context).pushNamed('/loginReg');
            }
            else{Navigator.of(context).pushNamed('/loginReg');}
          },
          child: Material(
            color: Colors.blue,
            child: SizedBox(width: 100.0, height: 100.0,),
          ),
        ),
      ),
    );
  }
}

class checkFirst
{
  static const firstLaunchKey = 'first_launch';
  static Future<bool> firstRun() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isFirst = await sp.getBool(firstLaunchKey) ?? true;

    if(isFirst){
      return true;
      //Todo:create database here
    }
    else{return false;}
  }
}