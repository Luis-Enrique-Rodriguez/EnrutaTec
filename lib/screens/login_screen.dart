import 'package:enrutatec/firebase/auth_with_google.dart';
import 'package:enrutatec/firebase/email_auth.dart';
import 'package:enrutatec/model/firebase_user.dart';
import 'package:enrutatec/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAuth = new EmailAuth();
  bool isSessionSaved = false;
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSavedSession();
    _user.user = _auth.user;
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
      backgroundColor: Color.fromARGB(255, 12, 144, 221),
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
          CircularProgressIndicator();
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
              Text('EnrutaTec',style: TextStyle(fontSize: 40),),
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
                //textCapitalization: TextCapitalization.characters,
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
                //textCapitalization: TextCapitalization.characters,
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
           ElevatedButton(onPressed: () {
            _login();
           }, child: _login()//_user.uid != null ? _logged() : _login() 
           ),
            ],
           
          )
          
        ],
        
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
       floatingActionButton: btnEntrar,
      
    );

  }

  ElevatedButton _login(){
    return ElevatedButton.icon(icon: Icon(Icons.login), label: Text('Sign with Google'), onPressed: () async{
      await _auth.signInGoogle();
      setState(() {
        _user.user= _auth.user;
        Navigator.pushNamed(context, '/dash');
      });
    });
  }

  /*Column _logged() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(_user.imageUrl!),
        ),
        Text(_user.name!),
        Text(_user.email!),
        ElevatedButton.icon( icon: Icon(Icons.logout), label: Text('Log Out'),
        onPressed: ()async {
          await _auth.signOutGoogle();
          Navigator.pushReplacementNamed(context, '/logout');
          setState(() {
            _user.user= _auth.user;
            Navigator.pushNamed(context, '/logout');
          });
        },
        )
      ],
    );
  }*/

}