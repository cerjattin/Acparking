// ignore_for_file: file_names

import '../models/Prop_Model.dart';
import 'package:acparking/utils/responsive.dart';
import 'package:acparking/widget/CamRegister.dart';
import 'package:acparking/widget/HomeUser.dart';
import 'package:acparking/widget/Pconfi.dart';
import 'package:acparking/widget/paymentpage.dart';
import 'package:acparking/provider/Prop_Provider.dart';
import 'package:flutter/material.dart';
import 'CustomerDrawer.dart';
import 'package:get/get.dart';

const List<String> list = <String>[
  'Seleccione la torre',
  'TORRE 1',
  'TORRE 2',
  'TORRE 3'
];
String dropdownValue = list.first;

class Register extends StatefulWidget {
  const Register({super.key, required this.textv});
  final String textv;
  static const String nombre = 'Regi';
  @override
  State<Register> createState() => _RegisterState();
}

class MiiControlador extends GetxController {
  final PropProvider propProvider = PropProvider();
  final TextEditingController _placa = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cel = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _torre = TextEditingController();
  final TextEditingController _apto = TextEditingController();
}

class _RegisterState extends State<Register> with WidgetsBindingObserver {
  bool estado = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final controlador = Get.put(MiiControlador());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
              65.0), // Define la altura deseada del AppBar
          child: AppBar(
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ],
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.green, // Cambia el color de fondo del AppBar
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      20.0), // Redondea el borde inferior izquierdo
                  bottomRight: Radius.circular(
                      20.0), // Redondea el borde inferior derecho
                ),
              ),
            ),
          )),
      drawer: const CustomerDrawer(),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffdcdbdb),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(children: <Widget>[
                          SizedBox(
                            width: 230,
                            child: TextField(
                              controller: controlador._placa,
                              decoration: InputDecoration(
                                  labelText: 'Placa',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  enabled: true,
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controlador._id,
                          decoration: InputDecoration(
                              labelText: 'Documento de identidad',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controlador._name,
                          decoration: InputDecoration(
                              labelText: 'Nombre del responsable',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controlador._cel,
                          decoration: InputDecoration(
                              labelText: 'Celular',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controlador._mail,
                          decoration: InputDecoration(
                              labelText: 'Mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 370,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.green),
                            underline: Container(
                              height: 2,
                              color: Colors.green,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                                controlador._torre.text = dropdownValue;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: controlador._apto,
                          decoration: InputDecoration(
                              labelText: 'Apartamento',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: true,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ]),
                ),
                ElevatedButton(
                  child: const Text('Registrar'),
                  onPressed: () {
                    String placa = controlador._placa.text;
                    String idPropietario = controlador._id.text;
                    String nombreResponsable = controlador._name.text;
                    String email = controlador._mail.text;
                    String apto = controlador._apto.text;
                    String cel = controlador._cel.text;
                    String torre = controlador._torre.text;

                    // enviar a firebase
                    PropModel propModel = PropModel(
                      placa: placa,
                      apto: apto,
                      id: idPropietario,
                      mail: email,
                      name: nombreResponsable,
                      telefono: cel,
                      torre: torre,
                      saldop: '',
                      fechapago: '',
                    );

                    // Limpiar todos los TextField
                    controlador._placa.clear();
                    controlador._id.clear();
                    controlador._name.clear();
                    controlador._cel.clear();
                    controlador._mail.clear();
                    controlador._apto.clear();

                    controlador.propProvider
                        .crearprop(propModel)
                        .then((success) {
                      if (success) {
                        return 'FUNCIONO';
                        // Operación exitosa
                        // Mostrar un mensaje o realizar alguna acción adicional
                      } else {
                        return 'FALLO';
                        // Operación fallida
                        // Mostrar un mensaje de error o realizar alguna acción adicional
                      }
                    });
                  },
                )
              ]),
              Positioned(
                  top: 45,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.green, size: 30.0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const CamRegister()));
                    },
                  )),
            ],
          ),
        ),
      )),
      bottomNavigationBar: SizedBox(
        height: responsive.height * 0.09,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                  20.0), // Redondea los bordes superiores izquierdos
              topRight: Radius.circular(
                  20.0), // Redondea los bordes superiores derechos
            ),
            child: BottomAppBar(
              color: Colors.green,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.home_filled,
                            color: Colors.white, size: 30.0),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeUser()));
                        }),
                    IconButton(
                        icon: const Icon(Icons.directions_car,
                            color: Colors.white, size: 30.0),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Pconfi(
                                    text: '',
                                  )));
                        }),
                    IconButton(
                        icon: const Icon(Icons.credit_card,
                            color: Colors.white, size: 30.0),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const paymentpage()));
                        }),
                  ]),
            )),
      ),
    );
  }
}
