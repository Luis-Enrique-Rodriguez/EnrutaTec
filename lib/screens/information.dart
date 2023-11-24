import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centro de ayuda'),
      ),
      body: ListView(children: [
        Text('¿Qué es EnrutaTec?') ,
        Text('EnrutaTec es una aplicación desarrollada por estudiantes del Tecnologico Nacional México en Celaya'),
        Text(''),
      ],)
    );
  }

}