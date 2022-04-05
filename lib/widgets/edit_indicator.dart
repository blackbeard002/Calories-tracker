import 'package:flutter/material.dart';

class Mini extends StatefulWidget {
  String maxCals;
  String consumedCals;

  Mini({
    Key? key,
    required this.maxCals,
    required this.consumedCals,
  }) : super(key: key);

  @override
  _MiniState createState() => _MiniState();
}

class _MiniState extends State<Mini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150.0,
      color: Colors.purple,
    );
  }
}

