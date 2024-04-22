// ignore_for_file: file_names, curly_braces_in_flow_control_structures, unused_element

import 'package:acparking/Provider/Placas_Provide.dart';
import 'package:acparking/models/Placas_Model.dart';
import 'package:acparking/utils/responsive.dart';
import 'package:acparking/widget/CustomerDrawer.dart';
import 'package:acparking/widget/HomeUser.dart';
import 'package:acparking/widget/Pconfi.dart';
import 'package:acparking/widget/paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class Visitor extends StatefulWidget {
  const Visitor({super.key, required this.textv});
  final String textv;

  @override
  State<Visitor> createState() => _VisitorState();
}

// DAMOS USO A LOS CONTROLADORES POR MEDIO DE GETX
class MiControladorr extends GetxController {
  final PlacasProvider placasProvider = PlacasProvider();
  final TextEditingController _placpr = TextEditingController();
  final TextEditingController _idP = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _plaut = TextEditingController();
  final TextEditingController _namepr = TextEditingController();
}

class _VisitorState extends State<Visitor> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate)
      setState(() {
        _endDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final controlador = Get.put(MiControladorr());
    return SafeArea(
      child: Scaffold(
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
            child: Stack(children: <Widget>[
              Column(
                children: <Widget>[
                  Column(children: <Widget>[
                    //Primer bloque
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
                                    controller: controlador._placpr,
                                    decoration: InputDecoration(
                                        labelText: 'Placa Principal',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                controller: controlador._namepr,
                                decoration: InputDecoration(
                                    labelText: 'Nombre del responsable',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabled: true,
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ])),
                    //Segundo bloque
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
                                    controller: controlador._plaut,
                                    decoration: InputDecoration(
                                        labelText: 'Placa Invitado',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                controller: controlador._name,
                                decoration: InputDecoration(
                                    labelText: 'Nombre del visitante',
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
                              const Text('Fecha de inicio'),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'Fecha de Inicio',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today,
                                          color: Colors.green, size: 20),
                                      onPressed: () =>
                                          _selectStartDate(context),
                                    )),
                                controller: TextEditingController(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(_startDate),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Fecha final'),
                              TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    hintText: 'Fecha Final',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today,
                                          color: Colors.green, size: 20),
                                      onPressed: () =>
                                          _selectStartDate(context),
                                    )),
                                controller: TextEditingController(
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(_startDate),
                                ),
                              ),
                            ])),
                    ElevatedButton(
                      child: const Text('Confirmar ingreso'),
                      onPressed: () async {
                        String propietario = controlador._idP.text;
                        String idVisitante = controlador._id.text;
                        String nombreVisitante = controlador._name.text;
                        String nomresp = controlador._namepr.text;
                        String placaut = controlador._plaut.text;
                        String placpr = controlador._placpr.text;
                        PlacasModel placasModel = PlacasModel(
                          saldo: '0',
                          estado: '0',
                          id: propietario,
                          document: idVisitante,
                          nameAutorizado: nombreVisitante,
                          nameResp: nomresp,
                          placpr: placpr,
                          placut: placaut,
                        );

                        controlador._id.clear();
                        controlador._idP.clear();
                        controlador._name.clear();
                        controlador._namepr.clear();
                        controlador._placpr.clear();
                        controlador._plaut.clear();

                        controlador.placasProvider
                            .crearplaca(placasModel)
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
                        // Agrega aquí la lógica para manejar el botón de la cámara
                      },
                    )
                  ]),
                ],
              ),
              //Camara bloaque 1
              Positioned(
                  top: 45,
                  right: 40,
                  child: IconButton(
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.green, size: 30.0),
                      onPressed: () {})),
              //Camara bloaque 2
              Positioned(
                  top: 250,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.green, size: 30.0),
                    onPressed: () {
                      // Agrega aquí la lógica para manejar el botón de la cámara
                    },
                  )),
            ]),
          )),
        ),
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
                          tooltip: 'Editar',
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
      ),
    );
  }
}
