// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //Menu
      child: ListView(
        children: [
          buildDrawerHeader(),
          Title(color: Colors.black, child: const Text('menu')),
          ListTile(
            title: const Text('Dashdoard Propietario'),
            onTap: () {
              Get.toNamed('/homeuser');
            },
          ),
          ListTile(
            title: const Text('Registro Visitantes'),
            onTap: () {
              Get.toNamed('/visitor');
            },
          ),
          ListTile(
            title: const Text('Registro Propietarios'),
            onTap: () {
              Get.toNamed('/register');
            },
          ),
          ListTile(
            title: const Text('Ingreso de Vehiculo'),
            onTap: () {
              Get.toNamed('/pconfi');
            },
          ),
          ListTile(
            title: const Text('Cerrar Sesión'),
            onTap: () {
              Get.toNamed('/home');
            },
          )
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text("Edgardo Cervantes"),
      accountEmail: Text("cerjattin@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('/imguser.jpg'),
      ),
      currentAccountPictureSize: Size.square(72),
      otherAccountsPictures: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text("CEOO"),
        )
      ],
      otherAccountsPicturesSize: Size.square(50),
    );
  }
}
