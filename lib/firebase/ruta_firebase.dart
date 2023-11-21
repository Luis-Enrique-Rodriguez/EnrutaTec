import 'package:cloud_firestore/cloud_firestore.dart';

class RutaFirebase{
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _rutasCollection;

  RutaFirebase(){
    _rutasCollection = _firebase.collection('ruta'); //Nombre de la base da datos
  }

  Future<void> insRutas(Map<String, dynamic> map) async  {
    return _rutasCollection!.doc().set(map);
  }

  Future<void> updRutas(Map<String, dynamic> map, String id) async  {
    return _rutasCollection!.doc(id).update(map);
  }

  Future<void> delRutas(String id) async  {
    return _rutasCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot>getAllRutas(){
    return _rutasCollection!.snapshots();
  }
}

FirebaseFirestore firebase = FirebaseFirestore.instance;

Future<List> getAllRutasList () async{
    List ruta = [];
    CollectionReference cr = firebase.collection('ruta');
    QuerySnapshot queryRuta = await cr.get();
    queryRuta.docs.forEach((documento) { 
      ruta.add(documento.data());
    });
    return ruta;
  }

/*Future <List> getRuta(String id) async {
  List ruta = [];
  CollectionReference collectionReference = firebase.collection('ruta');
  final _rutaID = collectionReference.doc().get(23);
  return ruta;
}*/
