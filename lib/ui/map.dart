import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practica_1/ui/menu_opciones.dart';
import 'dart:math';

class MapGoogle extends StatefulWidget {
  final LatLng fromPoint = LatLng(16.908167390431874, -92.0946973451528);
  LatLng myPoint = LatLng(16.903528, -92.102278);
  @override
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  late GoogleMapController _mapController;

  // Obtener localización
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Locación no activada');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso a localización denegada');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('localización denegada permanetemente');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Pintar mapa
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa"),
      ),
      drawer: menuOpciones(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 750,
              child: GoogleMap(
                compassEnabled: true,
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: widget.myPoint,
                  // tilt: 15,
                  zoom: 16,
                ),
                markers: _createMarkers(),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  setState(() {
                    _centerView();
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_pin_circle_outlined,
          size: 45,
        ),
        onPressed: () {
          _getCurrentLocation().then((value) {
            widget.myPoint = LatLng(value.latitude, value.longitude);
            setState(() {
              _centerView();
            });
          });
        },
      ),
      backgroundColor: Color.fromARGB(255, 0, 83, 1),
    );
  }

  // Crear las marcas en el mapa
  // Al presionar la marca se muestran las cordenadas de la ubicación
  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
        markerId: MarkerId("fromPoint"),
        position: widget.fromPoint,
        infoWindow:
            InfoWindow(title: "Centro", snippet: '${widget.fromPoint}')));
    tmp.add(
      Marker(
        markerId: MarkerId("myPoint"),
        position: widget.myPoint,
        infoWindow:
            InfoWindow(title: "Mi ubicación", snippet: '${widget.myPoint}'),
      ),
    );
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _centerView();
  }

  // Centrar la vista en base a los 2 puntos marcados
  _centerView() async {
    await _mapController.getVisibleRegion();

    var left = min(widget.fromPoint.latitude, widget.myPoint.latitude);
    var rigth = max(widget.fromPoint.latitude, widget.myPoint.latitude);
    var top = max(widget.fromPoint.longitude, widget.myPoint.longitude);
    var bottom = min(widget.fromPoint.longitude, widget.myPoint.longitude);

    var bounds = LatLngBounds(
        southwest: LatLng(left, bottom), northeast: LatLng(rigth, top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
}
