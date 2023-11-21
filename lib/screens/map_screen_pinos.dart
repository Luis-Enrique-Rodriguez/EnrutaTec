import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenPinos extends StatefulWidget {
  const MapScreenPinos({super.key});

  @override
  State<MapScreenPinos> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapScreenPinos> {
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
        LatLng(20.51338430449555, -100.78155391718857),
        LatLng(20.516569833939013, -100.77950595953261),
        LatLng(20.524833312228726, -100.77775572263678),
        LatLng(20.533121690382313, -100.77665505818739),
        LatLng(20.539302597554173, -100.778385771337),
        LatLng(20.54472793348819, -100.77973650538105),
        LatLng(20.54676401569741, -100.78014141714964),
        LatLng(20.548891159539394, -100.78104721406366),
        LatLng(20.54926140264817, -100.78485204675675),
        LatLng(20.550275133714727, -100.79597597528547),
        LatLng(20.55214465156337, -100.81536279303148),
        LatLng(20.55277012637329, -100.82186538530817),
        LatLng(20.553224100313912, -100.82363885963825),
        LatLng(20.554298019137274, -100.83157877708966),
        LatLng(20.54877859903943, -100.84082891303945),
        LatLng(20.544253157046878, -100.84267642620314),
        LatLng(20.536503602794777, -100.84589246730756),
        LatLng(20.528739906402944, -100.8485941914663),
        LatLng(20.526135094204488, -100.84938523754356),
        LatLng(20.51886246718435, -100.83744184678146),
        LatLng(20.51924429698621, -100.82982437312268),
        LatLng(20.519676366400574, -100.82487301541842),
        LatLng(20.51945028372864, -100.81334488102362),
        LatLng(20.519088550756734, -100.80925719467488),
        LatLng(20.519214152578048, -100.80532507609462),
        LatLng(20.51912688941401, -100.79546105071717),
        LatLng(20.517939947377513, -100.79107027475112),
        LatLng(20.516309614128616, -100.78462760860214),
      ],
    ),
  ];
  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.51338430449555, -100.78155391718857),
        infoWindow: InfoWindow(title: 'Base Pinos ATUCSA')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(20.516569833939013, -100.77950595953261),
        infoWindow: InfoWindow(title: 'Parada Town Plaza - Libramiento Norte')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(20.524833312228726, -100.77775572263678),
        infoWindow: InfoWindow(title: 'Parada La Burger')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(20.533121690382313, -100.77665505818739),
        infoWindow: InfoWindow(title: 'Parada ALOFT - Galerias Celaya')),
    Marker(
        markerId: MarkerId('5'),
        position: LatLng(20.539302597554173, -100.778385771337),
        infoWindow: InfoWindow(title: 'Parada PETCO')),
    Marker(
        markerId: MarkerId('6'),
        position: LatLng(20.54472793348819, -100.77973650538105),
        infoWindow: InfoWindow(title: 'Parada Farmacia Guadalajara - Olivos')),
    Marker(
      markerId: MarkerId('7'),
      position: LatLng(20.54676401569741, -100.78014141714964),
      infoWindow: InfoWindow(title: 'Parada GYM CENTER'),
    ),
    Marker(
        markerId: MarkerId('8'),
        position: LatLng(20.548891159539394, -100.78104721406366),
        infoWindow: InfoWindow(title: 'Parada Bodega Aurrera Express')),
    Marker(
        markerId: MarkerId('9'),
        position: LatLng(20.54926140264817, -100.78485204675675),
        infoWindow: InfoWindow(title: 'Parada Hotel del Amor')),
    Marker(
        markerId: MarkerId('10'),
        position: LatLng(20.550275133714727, -100.79597597528547),
        infoWindow: InfoWindow(title: 'Parada NovoPark')),
    Marker(
        markerId: MarkerId('11'),
        position: LatLng(20.55214465156337, -100.81536279303148),
        infoWindow: InfoWindow(title: 'Parada Susazon - Av. Mexico-Japon')),
    Marker(
        markerId: MarkerId('12'),
        position: LatLng(20.55277012637329, -100.82186538530817),
        infoWindow: InfoWindow(title: 'Parada CONALEP')),
    Marker(
        markerId: MarkerId('13'),
        position: LatLng(20.553224100313912, -100.82363885963825),
        infoWindow: InfoWindow(title: 'Parada Hotel Plaza Mexico')),
    Marker(
        markerId: MarkerId('14'),
        position: LatLng(20.554298019137274, -100.83157877708966),
        infoWindow: InfoWindow(title: 'Parada Motel Barcelona')),
    Marker(
        markerId: MarkerId('15'),
        position: LatLng(20.54877859903943, -100.84082891303945),
        infoWindow: InfoWindow(title: 'Parada Parque Celaya')),
    Marker(
        markerId: MarkerId('16'),
        position: LatLng(20.544253157046878, -100.84267642620314),
        infoWindow: InfoWindow(title: 'Parada Colonia Pinos')),
    Marker(
        markerId: MarkerId('17'),
        position: LatLng(20.536503602794777, -100.84589246730756),
        infoWindow: InfoWindow(title: 'Tribunal de Justicia')),
    Marker(
        markerId: MarkerId('18'),
        position: LatLng(20.528739906402944, -100.8485941914663),
        infoWindow: InfoWindow(title: 'Parada La Goliza')),
    Marker(
        markerId: MarkerId('19'),
        position: LatLng(20.526135094204488, -100.84938523754356),
        infoWindow: InfoWindow(title: 'Parada Mariscos Dany')),
    Marker(
        markerId: MarkerId('20'),
        position: LatLng(20.51886246718435, -100.83744184678146),
        infoWindow: InfoWindow(title: 'Parada Sportica')),
    Marker(
        markerId: MarkerId('21'),
        position: LatLng(20.51924429698621, -100.82982437312268),
        infoWindow: InfoWindow(title: 'Parada Beef Capital')),
    Marker(
      markerId: MarkerId('22'),
      position: LatLng(20.519676366400574, -100.82487301541842),
      infoWindow: InfoWindow(title: 'Parada Fonacot'),
    ),
    Marker(
      markerId: MarkerId('23'),
      position: LatLng(20.51945028372864, -100.81334488102362),
      infoWindow: InfoWindow(
          title: 'Parada Puente peatonal - Boulevard Adolfo Lopez Mateos'),
    ),
    Marker(
      markerId: MarkerId('24'),
      position: LatLng(20.519088550756734, -100.80925719467488),
      infoWindow: InfoWindow(title: 'Parada Comex Blvd'),
    ),
    Marker(
      markerId: MarkerId('25'),
      position: LatLng(20.519214152578048, -100.80532507609462),
      infoWindow: InfoWindow(title: 'Parada Fedex - Blvd'),
    ),
    Marker(
      markerId: MarkerId('26'),
      position: LatLng(20.51912688941401, -100.79546105071717),
      infoWindow: InfoWindow(title: 'Parada Chedraui - Blvd'),
    ),
    Marker(
      markerId: MarkerId('27'),
      position: LatLng(20.517939947377513, -100.79107027475112),
      infoWindow: InfoWindow(title: 'Parada La punta'),
    ),
    Marker(
      markerId: MarkerId('28'),
      position: LatLng(20.516309614128616, -100.78462760860214),
      infoWindow: InfoWindow(title: 'Parada Distribudora Coca-Cola'),
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
          ' Circuito Centro Norte',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: GoogleMap(
        polylines: Set<Polyline>.of(_polylines),
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
