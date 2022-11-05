import 'package:practica_1/model/db.dart';
import 'package:practica_1/model/platillo.dart';
import 'package:practica_1/ui/platillos_add.dart';
import 'package:practica_1/ui/menu_opciones.dart';
import 'package:flutter/material.dart';

enum categorias { comida, postres, bebidas }

class VistaPlatillos extends StatefulWidget {
  const VistaPlatillos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VistaPlatillos> createState() => _VistaPlatillosState();
}

class _VistaPlatillosState extends State<VistaPlatillos> {
  String? _token = "";
  List<Platillo> _platillos = [];
  List<PrecioMax> _precMax = [];
  TextEditingController _txtController = TextEditingController();
  RangeValues _rangeValues = RangeValues(0, 45);
  String valmin = '';
  String valmax = '';
  categorias? _character = categorias.comida;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperaToken();
  }

  void recuperaToken() async {
    _token = await Datos.leeToken();
    setState(() {});
  }

  Function refresca() {
    return () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        BackButton(onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }),
      ]),
      body: _token == ""
          ? CircularProgressIndicator()
          : FutureBuilder(
              future: Platillo.leeTodos(
                  '1', _txtController.text, valmin, valmax, ''),
              builder: (context, AsyncSnapshot<List<Platillo>> snapshot) {
                if (snapshot.hasData) {
                  _platillos = snapshot.data!;
                  return _columnaCentral();
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
      drawer: menuOpciones(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AgregaPlatillo(title: "", refrescaVentana: refresca()),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _filtros() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: TextField(
        controller: _txtController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            label: Text('Buscar:'), helperText: 'Busca platillos'),
      ),
      trailing: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          print("Buscando " + _txtController.text);
          setState(() {});
        },
      ),
    );
  }

  Widget _slicer() {
    // PrecioMax pre = _precMax[0];
    return RangeSlider(
      values: _rangeValues,
      divisions: 10,
      min: 0,
      max: 45,
      labels: RangeLabels(
        _rangeValues.start.round().toString(),
        _rangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        print('valmax' + valmax);
        print('valmin:' + valmin);
        // print(maxPrecio);
        setState(() {
          _rangeValues = values;
          valmin = _rangeValues.start.toStringAsFixed(0);
          valmax = _rangeValues.end.toStringAsFixed(0);
        });
      },
    );
  }

  Widget _categorias() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new Radio(
        value: categorias.comida,
        groupValue: categorias.comida,
        onChanged: (categorias? newcategoria) {
          setState(() {
            _character = newcategoria;
            print(newcategoria);
          });
        },
      ),
      new Text(
        'Comida',
        style: new TextStyle(fontSize: 16.0),
      ),
      Radio(
        value: categorias.postres,
        groupValue: categorias.postres,
        onChanged: (categorias? newcategoria) {
          setState(() {
            // _character = newcategoria;
            print(newcategoria);
          });
        },
      ),
      new Text(
        'Postres',
        style: new TextStyle(fontSize: 16.0),
      ),
      Radio(
        value: categorias.bebidas,
        groupValue: categorias.bebidas,
        onChanged: (categorias? newcategoria) {
          setState(() {
            // _character = newcategoria;
            print(newcategoria);
          });
        },
      ),
      new Text(
        'Bebidas',
        style: new TextStyle(fontSize: 16.0),
      ),
    ]);
  }

  Widget _columnaCentral() {
    return SingleChildScrollView(
        child: Column(
      children: [_filtros(), _slicer(), _categorias(), _listaPlatillos()],
    ));
  }

  Widget _listaPlatillos() {
    print("CREANDO LISTA CON " + _platillos.length.toString() + " PLATILLOS");
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Platillo p = _platillos[i];
        return ListTile(
          title: Text(p.nombre),
          subtitle: Text(p.descripcion),
          trailing: Text("\$" + p.precio.toString()),
        );
      },
      itemCount: _platillos.length,
    );
  }
}
