import 'package:acparking/models/Placas_Model.dart';
import 'package:acparking/provider/Placas_Provide.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final productM = PlacasModel();
  late Future<List<PlacasModel>> _listProductos;

  final productoProvider = PlacasProvider();

  @override
  void initState() {
    super.initState();
    final getProvider = PlacasProvider();
    _listProductos = getProvider.getplacas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(widget.title),
        ),
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: bFBwidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<PlacasModel>> bFBwidget() {
    return FutureBuilder(
      future: _listProductos,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<PlacasModel> prodctos = snapshot.data;
          print(prodctos);
          return ListView.builder(
            itemCount: prodctos.length,
            itemBuilder: (context, i) => cargarLista(context, prodctos[i]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget cargarLista(context, PlacasModel prod) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        productoProvider.borrarplacas(prod.id as String);
      },
      child: ListTile(
        title: Text(prod.nameAutorizado.toString()),
        subtitle: Text("\$ ${prod.document.toString()}"),
        trailing: const Icon(
          Icons.star,
          color: Colors.black26,
        ),
      ),
    );
  }
}
