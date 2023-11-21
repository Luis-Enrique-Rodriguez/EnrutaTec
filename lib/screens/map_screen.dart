import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const LatLng sourceLocation =
      LatLng(20.520385136074694, -100.81485567150284);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.488789332013937, -100.8013000044557),
        infoWindow: InfoWindow(title: 'Base Romeral')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(20.492121695424068, -100.80218419016636),
        infoWindow: InfoWindow(title: 'Parada Sitio de Querataro')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.496352444974203, -100.80427663479499),
        infoWindow: InfoWindow(title: 'Parada Contigo Si Gto')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(20.496788659779792, -100.80670718778694),
        infoWindow: InfoWindow(title: 'Parada Glorieta Romeral')),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(20.5016556562032, -100.80902929093705),
        infoWindow: InfoWindow(title: 'Parada Villa de los reyes')),
    Marker(
        markerId: MarkerId('6'),
        position: LatLng(20.501572001343213, -100.81223175185038),
        infoWindow: InfoWindow(title: 'Parada Modelorama')),
    Marker(
        markerId: MarkerId('7'),
        position: LatLng(20.50875121516274, -100.81420298790705),
        infoWindow: InfoWindow(title: 'Parada Verificentro')),
    Marker(
        markerId: MarkerId('8'),
        position: LatLng(20.51439157643493, -100.80708357271983),
        infoWindow: InfoWindow(title: 'Parada Central de autobuses')),
    Marker(
        markerId: MarkerId('9'),
        position: LatLng(20.51821543211251, -100.80769599550905),
        infoWindow: InfoWindow(title: 'Parada Antonio Plaza Su Krne')),
    Marker(
        markerId: MarkerId('10'),
        position: LatLng(20.519665994603447, -100.81204303044305),
        infoWindow: InfoWindow(title: 'Parada Mercado Hidalgo')),
    Marker(
        markerId: MarkerId('11'),
        position: LatLng(20.521255241423333, -100.81109887859951),
        infoWindow: InfoWindow(title: 'Parada Mercado Morelos')),
    Marker(
        markerId: MarkerId('12'),
        position: LatLng(20.521016258019923, -100.80463016282704),
        infoWindow: InfoWindow(title: 'Parada Calle Jose Maria')),
    Marker(
        markerId: MarkerId('13'),
        position: LatLng(20.52385416216673, -100.80387739312383),
        infoWindow: InfoWindow(title: 'Parada ITESI')),
    Marker(
        markerId: MarkerId('14'),
        position: LatLng(20.53055738165465, -100.80249944190801),
        infoWindow:
            InfoWindow(title: 'Parada Avenida Anenecuilco - 16 de Septiembre')),
    Marker(
        markerId: MarkerId('15'),
        position: LatLng(20.537144760086157, -100.80327425816643),
        infoWindow:
            InfoWindow(title: 'Parada Farmacia Guadalajara - Irrigacion ')),
    Marker(
        markerId: MarkerId('16'),
        position: LatLng(20.53692372339475, -100.80881158091434),
        infoWindow: InfoWindow(title: 'Parada UPN')),
    Marker(
        markerId: MarkerId('17'),
        position: LatLng(20.53671463432787, -100.81247973826676),
        infoWindow: InfoWindow(title: 'DIF - Irrigacion')),
    Marker(
        markerId: MarkerId('18'),
        position: LatLng(20.53852846694292, -100.81980470553545),
        infoWindow: InfoWindow(title: 'Parada ITC - Campus 1')),
    Marker(
        markerId: MarkerId('19'),
        position: LatLng(20.545178182340308, -100.82107291551979),
        infoWindow: InfoWindow(title: 'Parada Costco')),
    Marker(
        markerId: MarkerId('20'),
        position: LatLng(20.552305962892778, -100.82171664568071),
        infoWindow: InfoWindow(title: 'Parada OXXO - CONALEP')),
    Marker(
        markerId: MarkerId('21'),
        position: LatLng(20.552137692846024, -100.81356809457958),
        infoWindow: InfoWindow(
            title: 'Parada Transportes Leon-Celaya, Ciudad Industrial')),
    Marker(
      markerId: MarkerId('22'),
      position: LatLng(20.555533196059937, -100.80517814487713),
      infoWindow: InfoWindow(title: 'Parada Planta Pepsico'),
    ),
  ];
  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Honda - Romeral - CD. Industrial',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: sourceLocation,
          zoom: 14.4746,
        ),
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
