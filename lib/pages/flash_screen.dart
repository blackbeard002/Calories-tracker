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
            await checkFirst.firstRun();
            Navigator.of(context).pushNamed('/home');
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

  static Future<void> firstCall() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(firstLaunchKey, false);
  }
  static Future<void> firstRun() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isFirst = await sp.getBool(firstLaunchKey) ?? true;
    if(isFirst){
      //first run so set bool in firstCall
      await firstCall();
      //Todo:create database here
    }
  }
}