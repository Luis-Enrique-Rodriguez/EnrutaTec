class RutaModel{

  String? idRuta;
  String? nameRuta;
  String? imgRuta;

RutaModel({
  this.idRuta, 
  this.nameRuta,
  this.imgRuta
  });

  /*factory RutaModel.fromMap(Map<String, dynamic>map){
    return RutaModel(
      idRuta: map['numero'],
      nameRuta: map['nombre'],
      dscRuta: map['dsc'],
    );
  }*/


}