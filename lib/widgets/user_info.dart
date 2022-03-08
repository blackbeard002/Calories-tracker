import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userInfo extends StatefulWidget {
  const userInfo({Key? key}) : super(key: key);

  @override
  _userInfoState createState() => _userInfoState();
}

class _userInfoState extends State<userInfo> {
  String name = 'No Name';
  @override
  void initState()  {
    super.initState();
    getName();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 40.0, 5.0, 41.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                  offset: Offset.zero,
                  color: Colors.grey,
                  spreadRadius: 1.0,
                  blurRadius: 10.0
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              SizedBox(width: 20.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi ' + name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text('heres todays calorie count',
                    style: TextStyle(
                        fontSize: 13.0
                    ),
                  )
                ],
              ),
              SizedBox(width: 45.0,),
              GestureDetector(
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Icon(
                    Icons.settings,
                    size: 25,
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
  Future<void> getName() async
  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('uname') ?? 'no name';
  }
}
