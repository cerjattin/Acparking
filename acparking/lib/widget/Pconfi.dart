// ignore_for_file: file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'package:acparking/models/Placas_Model.dart';
import 'package:acparking/provider/Placas_Provide.dart';
import 'package:acparking/utils/responsive.dart';
//import 'package:acparking/widget/CamRegister.dart';
import 'package:acparking/widget/HomeUser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CustomerDrawer.dart';

class Pconfi extends StatefulWidget {
  const Pconfi({
    super.key,
    required this.text,
  });
  final String text;
  static const String nombre = 'Pconfi';

  @override
  State<Pconfi> createState() => _PconfiState();
}

class AuthService {
  final PlacasProvider _placaProvider = PlacasProvider();

  Future<String?> placautoriza(String placaut) async {
    try {
      print('antes del final placauto');
      final List<PlacasModel> placas = await _placaProvider.getplacas();
      print('despues del final placauto');
      for (var plac in placas) {
        if (plac.placut == placaut) {
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

class _PconfiState extends State<Pconfi> {
  final TextEditingController _placaController = TextEditingController();
  final autoriza = PlacasModel();
  late Future<List<PlacasModel>> _autoriza;

  final autorizaprovider = PlacasProvider();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final getProvider = PlacasProvider();
    _autoriza = getProvider.getplacas();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
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
                color: Colors.green,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffdcdbdb),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 230,
                              child: TextField(
                                controller: _placaController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: '',
                                    hintText: 'No. Placa'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Nombre responsable',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabled: false,
                              hintText: 'Nombre Responsable',
                              filled: true,
                              fillColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: 'Saldo pendiente',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Saldo Pendiente',
                              enabled: false,
                              filled: true,
                              fillColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffdcdbdb),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                  ),
                  ElevatedButton(
                    child: const Text('Confirmar ingreso'),
                    onPressed: () {},
                  )
                ],
              ),
              Positioned(
                  top: 45,
                  right: 80,
                  child: IconButton(
                    icon: const Icon(Icons.search,
                        color: Colors.green, size: 30.0),
                    onPressed: () {
                      // Agrega aquí la lógica para manejar el botón de la cámara
                      _validplaca(context);
                    },
                  )),
              Positioned(
                  top: 45,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.green, size: 30.0),
                    onPressed: () {
                      Get.toNamed('/CamRegister');

                      // Agrega aquí la lógica para manejar el botón de la cámara
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
                        icon: const Icon(Icons.home,
                            color: Colors.white, size: 30.0),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeUser()));
                        }),
                    IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.white, size: 30.0),
                        onPressed: () {}),
                    IconButton(
                        icon: const Icon(Icons.credit_card,
                            color: Colors.white, size: 30.0),
                        onPressed: () {}),
                  ]),
            )),
      ),
    );
  }

  Widget cargarLista(context, PlacasModel prod) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.blueGrey,
      ),
      /*onDismissed: (direccion) {
        PlacasProvider.borrarplacas(prod.placpr as String);
      },*/
      child: ListTile(
        title: Text(prod.nameAutorizado.toString()),
        subtitle: Text("\$ ${prod.document.toString()}"),
        trailing: Icon(
          Icons.star,
          color: prod.placut != null ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }

  void _validplaca(BuildContext context) async {
    String placaut = _placaController.text;
    print(_placaController.text);

    String? userType = await AuthService().placautoriza(placaut);
    print('despues de placautoriza');
    if (userType != null) {
      // Aquí decides a qué página navegar basado en el tipo de usuario
      if (userType == 'residente') {
        // ignore: use_build_context_synchronously
        print('encontro registro');
      }
    } else {
      // Mostrar algún mensaje de error
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Vehiculo NO autorizado'),
            content: const Text('Comunicarse con Propietario.'),
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
