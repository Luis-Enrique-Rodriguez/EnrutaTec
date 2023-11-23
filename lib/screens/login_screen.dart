import 'dart:async';

import 'package:enrutatec/assets/loading.dart';
import 'package:enrutatec/firebase/auth_with_google.dart';
import 'package:enrutatec/firebase/email_auth.dart';
import 'package:enrutatec/model/firebase_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailAuth = new EmailAuth();
  AccessToken? _accessToken;
  bool isSessionSaved = false;
  Map<String, dynamic>? _userData;
  late StreamSubscription _subs;

  bool loader = false;
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();
  bool _checking = false;

@override
  void initState() {
    super.initState();
    checkSavedSession();
    loader = false;
    _initDeepLinkListener();
    _user.user = _auth.user;
    
  }

 void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      emailAuth.signInWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
    }
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
      
    });
    if(accessToken != null){
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }else{
      _loginFB();
    }
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
              title: Text('Error \n - Los campos no pueden estar vacíos \n - Correo o Contraseña Incorrectos', style: TextStyle(fontSize: 10),),
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
          LoadingPage(); 
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
      //backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              Text('EnrutaTec',
              style: TextStyle(fontSize: 40), 
              
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Color.fromARGB(11, 255, 255, 255),
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
                child: Divider()
              ),
              TextField(
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: 'Correo',
                  labelText: 'Correo',
                  suffix: Icon(
                    Icons.verified_user
                  ) ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
                controller: txtConUser,
              ),
              Divider(height: 30),
              TextField(
                enableInteractiveSelection: false,
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
          Column(
            children: [
              _login(),
              _loginFB(),
              _loginGh(),
              btnEntrar
            ],
          ),
           /*ElevatedButton(onPressed: () {
            //_login();
            //_loginFB();
           }, child: _login(), _loginFB //_user.uid != null ? _logged() : _login() 
           ),
           Divider(height: 5,),
           ElevatedButton(onPressed: (){
              
           }, child: btnEntrar)*/ 
            ],
           
          )
          
        ],
      ),      
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

  ElevatedButton _loginFB() {
    return ElevatedButton.icon(icon: Icon(Icons.login), label: Text('Sign with Facebook'), onPressed: () async{
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success){
        _accessToken = result.accessToken;
        final userData = await FacebookAuth.instance.getUserData();
        _userData=_userData;
      }else{
        print(result.status);
        print(result.message);
      }
      setState(() {
        _checking=false;
        Navigator.pushNamed(context, '/dash');
      });
    });
  }

  _logoutFB() async{
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {
    });
  }


ElevatedButton _loginGh() {
    return ElevatedButton.icon(icon: Icon(Icons.login), label: Text('Sign with GitHub'), onPressed: () async{ 
      setState(() {
        _loginGH();
        //Navigator.pushNamed(context, '/dash');
      });
    });
  }


  _loginGH() async{
    const String url =
        "https://github.com/login/oauth/authorize?client_id=1909009eb9d726bcead9&scope=public_repo%20read:user%20user:email";
    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      // ignore: deprecated_member_use
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
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