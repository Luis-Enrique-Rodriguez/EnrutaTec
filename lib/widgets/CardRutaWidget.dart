import 'package:enrutatec/model/ruta_model.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:enrutatec/screens/map_screen.dart';
import 'package:flutter/material.dart';

class CardRutaWidget extends StatelessWidget {
  CardRutaWidget({super.key, required this.rutaModel});
  RutaModel rutaModel;

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(  
        color: Colors.amber
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(rutaModel.idRuta!),
              Text(rutaModel.nameRuta!),
              Text(rutaModel.imgRuta!)
              
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen())) ,
                child: null 
                ),
              IconButton(
                onPressed: (){
                  
                }, 
              icon: Icon(Icons.delete)
              )
            ],
          )
        ],
      ),
    );
    
  }



  
}