import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width, height, inch;
  Responsive({
    required this.width,
    required this.height,
    required this.inch,
  });

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(
        width: data.size.width, height: data.size.height, inch: inch);
  }

  get horizontalPadding => null;

  double wp(double percent) {
    assert(
        percent >= 0 && percent <= 1, "Percent value must be between 0 and 1");
    return (width * percent / 100);
  }

  double hp(double percent) {
    assert(
        percent >= 0 && percent <= 1, "Percent value must be between 0 and 1");
    return (height * percent / 100);
  }

  double ip(double percent, {required int percentage}) {
    return (inch * percent / 100);
  }
}
