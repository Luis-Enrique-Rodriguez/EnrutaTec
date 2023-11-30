import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = auth.currentUser!;
    final Page name;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nombre: ${user.displayName ?? 'No disponible'}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Correo electrónico: ${user.email ?? 'No disponible'}',
              style: TextStyle(fontSize: 24),
            ),
            // Agrega aquí más campos según sea necesario
          ],
        ),
      ),
    );
  }
}
