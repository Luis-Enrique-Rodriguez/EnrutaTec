import 'package:enrutatec/firebase/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

    final conNameUser = TextEditingController();
    final conEmailUser = TextEditingController();
    final conPwdUser = TextEditingController();
    final emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Usuario')),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 90
        ),
        children: <Widget>[
          Divider(height: 50,),
          Column(
            children: [
              Text(
                'Registrate',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
          Divider(height: 50,),
            TextFormField(
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  hintText: 'Usuario',
                  labelText: 'Usuario',
                  suffix: Icon(
                    Icons.verified_user
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              controller: conNameUser,
            ),
          Divider(height: 25,),
            TextFormField(
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  hintText: 'Correo',
                  labelText: 'Correo',
                  suffix: Icon(
                    Icons.verified_user
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              controller: conEmailUser,
            ),
          Divider(height: 25,),
            TextFormField(
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  suffix: Icon(
                    Icons.verified_user
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
              controller: conPwdUser,
              obscureText: true,
            ),
          Divider(height: 5,),
            Text('La contraseña debe contener al menos 6 caracteres'),
          Divider(height: 50,),
            ElevatedButton(onPressed: (){
              var email = conEmailUser.text;
              var pwd = conPwdUser.text;
              emailAuth.createUser(emailUser: email, pwdUser: pwd);
              
            }, 
            child: Text('Registrar'))
          ]
          ),
        ]
      ),
    );
  }
}