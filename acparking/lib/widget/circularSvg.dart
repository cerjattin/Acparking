import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularSvgPicture extends StatelessWidget {
  final String assetName;
  final double size;

  CircularSvgPicture(this.assetName, {required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        child: SvgPicture.asset(
          assetName,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
