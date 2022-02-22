import 'package:calories_tracker/widgets/custom-rect-tween.dart';
import 'package:flutter/material.dart';

class searchFoods extends StatefulWidget {
  const searchFoods({Key key}) : super(key: key);

  @override
  _searchFoodsState createState() => _searchFoodsState();
}

class _searchFoodsState extends State<searchFoods> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 10, 32, 32),
        child: Hero(
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          tag: 'hero-search-test',
          child: Material(
            color: Colors.orange,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for Foods',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
