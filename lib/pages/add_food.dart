import 'package:flutter/material.dart';

class addfood extends StatefulWidget {
  const addfood({Key key}) : super(key: key);

  @override
  _addfoodState createState() => _addfoodState();
}

class _addfoodState extends State<addfood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add food"),
      ),
      body: Text("add food"),
    );
  }
}

