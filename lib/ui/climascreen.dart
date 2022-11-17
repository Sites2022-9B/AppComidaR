import 'package:flutter/material.dart';
import 'package:practica_1/ui/clima.dart';

import 'package:practica_1/model/weather.dart';
import 'package:practica_1/ui/menu_opciones.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherService weatherService = WeatherService();
  Weather weather = Weather();

  String currentWeather = "";
  double tempC = 0;
  String ciudad = "";
  String icono = "";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async {
    weather = await weatherService.getWeatherData("Ocosingo");

    setState(() {
      currentWeather = weather.condition;
      tempC = weather.temperatureC;
      ciudad = weather.city;
      icono = weather.iconcond;
    });
    print(weather.temperatureC);
    print(weather.condition);
    print(weather.city);
    print(weather.iconcond);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima'),
      ),
      drawer: menuOpciones(context),
      backgroundColor: Color.fromARGB(255, 5, 29, 72),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lugar",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Card(
              color: Color.fromARGB(255, 58, 145, 216),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.all(12.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          ciudad,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
              ),
            ),
            Text(
              "Condición climatica",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Card(
              elevation: 12.0,
              color: Color.fromARGB(255, 204, 196, 196),
              // color: Color.fromARGB(255, 34, 174, 165),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7.0),
                padding: EdgeInsets.all(12.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 35,
                        child: Image.network(
                          "https:" + icono,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          currentWeather,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
              ),
            ),
            Text(
              "Grados Centigrados",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Card(
              elevation: 12.0,
              color: Color.fromARGB(255, 34, 174, 165),
              // color: Color.fromARGB(255, 204, 196, 196),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7.0),
                padding: EdgeInsets.all(12.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.thermostat,
                        color: Color.fromARGB(255, 187, 0, 0),
                        size: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          tempC.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ]),
              ),
            ),
            // Text(ciudad),
            // Text(currentWeather),
            // Text(tempC.toString()),
            // Text(tempF.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh_rounded),
        onPressed: getWeather,
      ),
    );
  }
}
