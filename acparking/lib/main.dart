import 'package:acparking/widget/CamRegister.dart';
import 'package:acparking/widget/HomeUser.dart';
import 'package:acparking/widget/Pconfi.dart';
import 'package:acparking/widget/Register.dart';
import 'package:flutter/material.dart';
import 'widget/Session.dart';
import 'widget/SplashScreen.dart';
import 'widget/CreateVisitor.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        // nuestra pagina inicial sera el splash de cargando
        initialRoute: "/splash",

        // determinamos todas las paginas con su respectivo nombre para luego llamarlas en otras clases
        getPages: [
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/home', page: () => const Session()),
          GetPage(name: '/homeuser', page: () => const HomeUser()),
          GetPage(
              name: '/visitor',
              page: () => const Visitor(
                    textv: '',
                  )),
          GetPage(name: '/pconfi', page: () => const Pconfi(text: '')),
          GetPage(name: '/register', page: () => const Register(textv: '')),
          GetPage(name: '/CamRegister', page: () => const CamRegister()),
        ]);
  }
}
