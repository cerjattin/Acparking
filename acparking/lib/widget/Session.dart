// ignore_for_file: file_names

import 'package:acparking/models/User_Model.dart';
import 'package:acparking/provider/User_Provider.dart';
import 'package:acparking/screens/welcome.dart';
import 'package:acparking/utils/responsive.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'HomeUser.dart';
import 'package:get/get.dart';

class Session extends StatefulWidget {
  const Session({super.key});
  static const String nombre = 'inicio_S';

  @override
  State<Session> createState() => _SessionState();
}

class AuthService {
  final UserProvider _userProvider = UserProvider();

  Future<String?> iniciarSesion(String email, String password) async {
    try {
      final List<UserModel> users = await _userProvider.getuser();
      for (var user in users) {
        if (user.mail == email && user.pass == password) {
          // Aquí podrías determinar el tipo de usuario
          return "residente"; // Simula que todos son residentes, ajusta según tus necesidades
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}

class MiControlador extends GetxController {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late bool _acceptTerms = false;
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final controlador = Get.put(MiControlador());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: responsive.height * 0.03,
              vertical: responsive.width * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const welcome(),
                const SizedBox(height: 80),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Email", prefixIcon: Icon(Icons.mail)),
                  controller: controlador._emailController,
                ),
                SizedBox(height: responsive.height * 0.02),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Contraseña",
                      prefixIcon: Icon(Icons.key_rounded)),
                  controller: controlador._passwordController,
                ),
                SizedBox(height: responsive.height * 0.02),
                CheckboxListTile(
                  value: controlador._acceptTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      controlador._acceptTerms = value ?? false;
                    });
                  },
                  title: const Text("Acepto los términos y condiciones."),
                ),
                if (!controlador._acceptTerms)
                  Text(
                    "Por favor, aceptar  los términos y condiciones para continuar.",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.redAccent),
                  ),
                SizedBox(height: responsive.height * 0.04),
                ElevatedButton.icon(
                    onPressed: () {
                      if (controlador._acceptTerms == true) {
                        _login(context);
                      }
                      validateEmail();
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Ingresar'))
              ]),
        ),
      ),
    );
  }

  void validateEmail() {
    final controlador = Get.put(MiControlador());
    final bool isValid =
        EmailValidator.validate(controlador._emailController.text.trim());
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formato de Correo no Valido')));
    }
  }

  void _login(BuildContext context) async {
    final controlador = Get.put(MiControlador());
    String email = controlador._emailController.text;
    String password = controlador._passwordController.text;

    String? userType = await AuthService().iniciarSesion(email, password);

    if (userType != null) {
      // Aquí decides a qué página navegar basado en el tipo de usuario
      if (userType == 'residente') {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeUser()));
      }
    } else {
      // Mostrar algún mensaje de error
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error de Inicio de Sesión'),
            content: const Text('Correo electrónico o contraseña incorrectos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
