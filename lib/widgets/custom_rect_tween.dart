//currently not in use because of nullable bullshit
//will come back soon
//btw have you heard of tipadis?


/*import 'dart:ui';

import 'package:flutter/widgets.dart';

class CustomRectTween extends RectTween {
  CustomRectTween({
    required Rect? begin,
    required Rect? end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      double? lerpDouble(begin?.left, end?.left, elasticCurveValue),
      double? lerpDouble(begin?.top, end?.top, elasticCurveValue),
      double? lerpDouble(begin?.right, end?.right, elasticCurveValue),
      double? lerpDouble(begin?.bottom, end?.bottom, elasticCurveValue),
    );
  }
}*/
