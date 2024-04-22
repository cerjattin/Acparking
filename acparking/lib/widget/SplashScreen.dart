// ignore_for_file: file_names

import 'package:acparking/widget/Session.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 4);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Session()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Splashscr.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      titleTextStyle: TextStyle(color: Colors.white),
                      title: Text(
                        "App Parqueadero",
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        "Bienvenido a la app",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 20,
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
