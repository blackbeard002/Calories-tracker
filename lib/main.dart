import 'package:flutter/material.dart';
import 'package:calories_tracker/pages/home.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => home(),
      },
    )
);
