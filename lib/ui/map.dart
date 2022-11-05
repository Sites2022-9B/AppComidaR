import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practica_1/ui/menu_opciones.dart';
import 'dart:math';

class MapGoogle extends StatefulWidget {
  final LatLng fromPoint = LatLng(16.908167390431874, -92.0946973451528);
  final LatLng NextPoint = LatLng(16.905140, -92.106839);
  @override
  _MapGoogleState createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {
  late GoogleMapController _mapController;
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
                  target: widget.NextPoint,
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
        child: Icon(Icons.zoom_in_map),
        onPressed: _centerView,
      ),
      backgroundColor: Color.fromARGB(255, 0, 83, 1),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
        markerId: MarkerId("fromPoint"),
        position: widget.fromPoint,
        infoWindow: InfoWindow(title: "Mi restaurant")));
    tmp.add(Marker(
        markerId: MarkerId("NextPoint"),
        position: widget.NextPoint,
        infoWindow: InfoWindow(title: "Cliente")));
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _centerView();
  }

  _centerView() async {
    await _mapController.getVisibleRegion();

    var left = min(widget.fromPoint.latitude, widget.NextPoint.latitude);
    var rigth = max(widget.fromPoint.latitude, widget.NextPoint.latitude);
    var top = max(widget.fromPoint.longitude, widget.NextPoint.longitude);
    var bottom = min(widget.fromPoint.longitude, widget.NextPoint.longitude);

    var bounds = LatLngBounds(
        southwest: LatLng(left, bottom), northeast: LatLng(rigth, top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
}
