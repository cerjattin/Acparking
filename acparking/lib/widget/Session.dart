// ignore_for_file: file_names

import 'package:acparking/screens/welcome.dart';
import 'package:acparking/utils/responsive.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'HomeUser.dart';
import 'package:get/get.dart';

class Session extends StatefulWidget {
  const Session({super.key});
  static const String nombre = 'inicio_S';

  @override
  State<Session> createState() => _SessionState();
}

class MiControlador extends GetxController {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late bool _acceptTerms = true;
}

class _SessionState extends State<Session> {
  final AuthService _authService = AuthService();
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
                    onPressed: () async {
                      {
                        String emailuser =
                            controlador._emailController.text.trim();
                        String password =
                            controlador._passwordController.text.trim();
                        if (emailuser.isNotEmpty && password.isNotEmpty) {
                          try {
                            await _authService.login(emailuser, password);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeUser()),
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Invalid e-Mail or password.'),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Please enter a username and password.'),
                          ));
                        }
                      }
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
}
