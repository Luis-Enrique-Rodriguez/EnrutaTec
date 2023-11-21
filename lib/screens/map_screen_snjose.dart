import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenSanJose extends StatefulWidget {
  const MapScreenSanJose({super.key});

  @override
  State<MapScreenSanJose> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapScreenSanJose> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const LatLng sourceLocation =
      LatLng(20.520385136074694, -100.81485567150284);

  final List<Polyline> _polylines = [
    const Polyline(
      polylineId: PolylineId('1'),
      color: Colors.blue,
      width: 5,
      points: [
        LatLng(20.422694577307826, -100.77145658641848), // Base San Jose
        LatLng(20.44394824304009, -100.77278696202893), // Parada San Jose
        LatLng(20.454446042168758,
            -100.79152248655224), // Parada Finca Familiar 3 Hermanos
        LatLng(20.457518284441374,
            -100.7976594732467), // Parada Carniceria La Cruz
        LatLng(20.464085775359344,
            -100.80734490979222), // Parada Balneario Los Arcos
        LatLng(20.51388842141818,
            -100.80782974438813), // Parada Central de Autobuses
        LatLng(20.52056634316784,
            -100.81711721815333), // Parada Casa Doña Emeteria Valencia
        LatLng(
            20.523250485096835, -100.81827073653592), // Parada Manuel Doblado
        LatLng(20.527460910061233, -100.82044947612896), // Parada 3B
        LatLng(20.531834394203415, -100.82043735862368), // Parada Vias del Tren
        LatLng(20.5355287113783, -100.82405037900756), // Parada Parque Ximhai
        LatLng(20.53857782748368, -100.81990458552409), // Parada ITC - Campus 1
        LatLng(20.545361826119738, -100.82113303726413), // Parada Costco
        LatLng(20.553170210111652,
            -100.82256265465045), // Parada Modelorama - La corona
        LatLng(20.566744690673943, -100.82156892389753), // Parada OXXO Praderas
        LatLng(20.56797268926507, -100.82187469573392), // Parada Praderas
        LatLng(20.578142671340235, -100.82778231142314), // Parada Tec Roque
        LatLng(
            20.582009665736518, -100.83828584183686), // Parada Roque Guanajuato
      ],
    ),
  ];

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.422694577307826, -100.77145658641848),
        infoWindow: InfoWindow(title: 'Base San Jose')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(20.44394824304009, -100.77278696202893),
        infoWindow: InfoWindow(title: 'Parada San Jose')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.454446042168758, -100.79152248655224),
        infoWindow: InfoWindow(title: 'Parada Finca Familiar 3 Hermanos')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(20.457518284441374, -100.7976594732467),
        infoWindow: InfoWindow(title: 'Parada Carniceria La Cruz')),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(20.464085775359344, -100.80734490979222),
        infoWindow: InfoWindow(title: 'Parada Balneario Los Arcos')),
    Marker(
        markerId: MarkerId('6'),
        position: LatLng(20.51388842141818, -100.80782974438813),
        infoWindow: InfoWindow(title: 'Parada Central de Autobuses')),
    Marker(
      markerId: MarkerId('7'),
      position: LatLng(20.52056634316784, -100.81711721815333),
      infoWindow: InfoWindow(title: 'Parada Casa Doña Emeteria Valencia'),
    ),
    Marker(
        markerId: MarkerId('8'),
        position: LatLng(20.523250485096835, -100.81827073653592),
        infoWindow: InfoWindow(title: 'Parada Manuel Doblado')),
    Marker(
        markerId: MarkerId('9'),
        position: LatLng(20.527460910061233, -100.82044947612896),
        infoWindow: InfoWindow(title: 'Parada 3B')),
    Marker(
        markerId: MarkerId('10'),
        position: LatLng(20.531834394203415, -100.82043735862368),
        infoWindow: InfoWindow(title: 'Parada Vias del Tren')),
    Marker(
        markerId: MarkerId('11'),
        position: LatLng(20.5355287113783, -100.82405037900756),
        infoWindow: InfoWindow(title: 'Parada Parque Ximhai')),
    Marker(
        markerId: MarkerId('12'),
        position: LatLng(20.53857782748368, -100.81990458552409),
        infoWindow: InfoWindow(title: 'Parada ITC - Campus 1')),
    Marker(
        markerId: MarkerId('13'),
        position: LatLng(20.545361826119738, -100.82113303726413),
        infoWindow: InfoWindow(title: 'Parada Costco')),
    Marker(
        markerId: MarkerId('14'),
        position: LatLng(20.553170210111652, -100.82256265465045),
        infoWindow: InfoWindow(title: 'Parada Modelorama - La corona')),
    Marker(
        markerId: MarkerId('15'),
        position: LatLng(20.566744690673943, -100.82156892389753),
        infoWindow: InfoWindow(title: 'Parada OXXO Praderas')),
    Marker(
        markerId: MarkerId('16'),
        position: LatLng(20.56797268926507, -100.82187469573392),
        infoWindow: InfoWindow(title: 'Parada Praderas')),
    Marker(
        markerId: MarkerId('17'),
        position: LatLng(20.578142671340235, -100.82778231142314),
        infoWindow: InfoWindow(title: 'Parada Tec Roque')),
    Marker(
      markerId: MarkerId('18'),
      position: LatLng(20.582009665736518, -100.83828584183686),
      infoWindow: InfoWindow(title: 'Parada Roque Guanajuato'),
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
          'San Jose > Roque',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        polylines: Set<Polyline>.of(_polylines),
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
