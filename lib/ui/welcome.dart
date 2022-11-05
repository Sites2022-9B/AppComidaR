import 'package:practica_1/model/db.dart';
import 'package:flutter/material.dart';

import '../model/pedido.dart';
import 'menu_opciones.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String? _token = "";
  List<Pedido> _pedidos = [];
  String _filtroSeleccionado = "PEDIDO";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperaToken();
    leePedidos();
  }

  void recuperaToken() async {
    _token = await Datos.leeToken();
    setState(() {});
  }

  void leePedidos() {
    _pedidos.add(Pedido(
        id: 1,
        cliente: "Cliente 1",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PEDIDO"));
    _pedidos.add(Pedido(
        id: 2,
        cliente: "Cliente 2",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PEDIDO"));
    _pedidos.add(Pedido(
        id: 3,
        cliente: "Cliente 3",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PROCESO"));
    _pedidos.add(Pedido(
        id: 4,
        cliente: "Cliente 4",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PROCESO"));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: _columnaCentral(),
  //     drawer: menuOpciones(context),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/registrar.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: _columnaCentral(),
        drawer: menuOpciones(context),
      ),
    );
  }

  Widget _columnaCentral() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _filtros(),
        _listaPedidos(),
      ],
    ));
  }

  Widget _filtros() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
          value: "PEDIDO",
          groupValue: _filtroSeleccionado,
          onChanged: (value) {
            setState(() {
              _filtroSeleccionado = "PEDIDO";
            });
          }),
      Text("Pedidos"),
      Radio(
          value: "PROCESO",
          groupValue: _filtroSeleccionado,
          onChanged: (value) {
            setState(() {
              _filtroSeleccionado = "PROCESO";
            });
          }),
      Text("En Proceso"),
    ]);
  }

  Widget _listaPedidos() {
    List<Pedido> _filtrados = [];
    for (Pedido p in _pedidos) {
      if (p.status == _filtroSeleccionado) {
        _filtrados.add(p);
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Pedido p = _filtrados[i];
        return ListTile(
          title: Text("#" + p.id.toString() + " " + p.fecha.toString()),
          subtitle: Text(p.cliente + " \$" + p.total.toString()),
          trailing: IconButton(
            icon: Icon(p.status == "PEDIDO" ? Icons.tab : Icons.access_alarms),
            onPressed: null,
            color: Colors.green,
          ),
        );
      },
      itemCount: _filtrados.length,
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //         child: Column(children: <Widget>[
  //       Text('BIENVENIDO ' + _token!),
  //     ])),
  //   );
  // }

