// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:acparking/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class welcome extends StatelessWidget {
  const welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return AspectRatio(
      aspectRatio: 16 / 13,
      child: LayoutBuilder(
        builder: (_, Constraints) {
          return Stack(
            children: <Widget>[
              Positioned(
                  top: responsive.height * 0.25,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: responsive.width,
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      Text(
                        "Bienvenido a su App Parking!",
                        style: TextStyle(
                            fontSize: responsive.ip(2, percentage: 2),
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  )),
              Positioned(
                  top: Constraints.minHeight * 0.24,
                  left: 0,
                  child: SvgPicture.asset(
                    "assets/home.svg",
                    width: Constraints.maxWidth * 0.375,
                  )),
              Positioned(
                  top: Constraints.minHeight * 0.46,
                  right: 0,
                  child: SvgPicture.asset(
                    "assets/scudo.svg",
                    width: Constraints.maxWidth * 0.25,
                  ))
            ],
          );
        },
      ),
    );
  }
}
