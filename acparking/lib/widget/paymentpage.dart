// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class paymentpage extends StatefulWidget {
  const paymentpage({super.key});
  static const String nombre = 'State';

  @override
  State<paymentpage> createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  bool estado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green, //color
          title: const Text(''),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ],
        ),
        body: SafeArea(
            // CODIFICACION PAGINA HOME
            child: Column(children: [
          const SizedBox(
            height: 60,
          ),
          Center(child: Image.asset('assets/payment.png')),
          const SizedBox(
            height: 270,
          ),
          const Text('¡en un momento seras redirigido!'),
        ])));
  }
}
