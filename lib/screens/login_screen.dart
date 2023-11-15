

import 'package:enrutatec/firebase/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAuth = new EmailAuth();
   bool isSessionSaved = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSavedSession();
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      Navigator.pushReplacementNamed(context, '/dash'); 
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();


final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      backgroundColor: Colors.black,
      onPressed: () async {
        bool res = await emailAuth.validateUser(emailUser: txtConUser.text, pwdUser: txtConPass.text);
        if(txtConUser!=null && txtConPass!=null){
          showDialog(context: context, 
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Error \n - Los campos no pueden estar vacíos \n - Correo o Contraseña Incorrectos', style: TextStyle(fontSize: 16),),
              
              icon: Icon(Icons.warning),
              actions: [
              Align(
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('Aceptar'),),
                ),
                
              ],
            );
          } );
        }if(res){
           Navigator.pushNamed(context, '/dash');
          saveSession(isSessionSaved);
        }
        
      },
    );

final sessionCheckbox = Checkbox(
      value: isSessionSaved,
      onChanged: (value) {
        setState(() {
          isSessionSaved = value!;
        });
      },
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 90.0
        ),
        children: <Widget> [
          Divider(height: 50,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('images/autobus.gif'),
              ),
              Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(
                width: 160.0,
                height: 15.0,
                child: Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                )
              ),
              TextField(
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
                controller: txtConUser,
              ),
              Divider(height: 30),
              TextField(
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  suffix: Icon(
                    Icons.password
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
                controller: txtConPass,
                obscureText: true,
              ),

              TextButton(
                  
                  onPressed: () => Navigator.pushNamed(context, '/register'), 
                  child: const Text('¿No tienes una cuenta? Registrate', 
                  style: TextStyle(fontSize: 15),
                  )
                
      ),
           
            ],
           
          )
          
        ],
        
      ),
       floatingActionButton: btnEntrar,
     
      
      
    );
    
  }
}