class RutaModel{

  String? idRuta;
  String? nameRuta;
  String? dscRuta;

RutaModel({
  this.idRuta, 
  this.nameRuta,
  this.dscRuta
  });

  /*factory RutaModel.fromMap(Map<String, dynamic>map){
    return RutaModel(
      idRuta: map['numero'],
      nameRuta: map['nombre'],
      dscRuta: map['dsc'],
    );
  }*/


}