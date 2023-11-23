import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:enrutatec/firebase/auth_with_google.dart';
import 'package:enrutatec/firebase/ruta_firebase.dart';
import 'package:enrutatec/screens/login_screen.dart';
import 'package:enrutatec/screens/map_screen.dart';
import 'package:enrutatec/screens/map_screen_pinos.dart';
import 'package:enrutatec/screens/map_screen_snjose.dart';
import 'package:enrutatec/widgets/CardRutaWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enrutatec/assets/global_values.dart';
import 'package:enrutatec/model/firebase_user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  RutaFirebase? rutasFirebase;
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _auth = AuthServiceGoogle();
  AccessToken? _accessToken;
  Map<String, dynamic>? _userData;

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
    Navigator.pushReplacementNamed(context, '/logout');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user.user = _auth.user;
    rutasFirebase = RutaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EnrutaTec'),
        ),
        drawer: createDrawer(),
        body: Column(
          children: [
            buildCustomCard(
                'https://www.celaya.gob.mx/wp-content/uploads/2023/02/Cya21-24_horizontal-01.png',
                '23',
                'San Jose > Roque',
                () => navigateTo23(context)),
            buildCustomCard(
                'https://www.celaya.gob.mx/wp-content/uploads/2023/02/Cya21-24_horizontal-01.png',
                '43',
                'Honda - Romeral -  CD. Industrial',
                () => navigateTo43(context)),
            buildCustomCard(
                'https://www.celaya.gob.mx/wp-content/uploads/2023/02/Cya21-24_horizontal-01.png',
                '60',
                'Circuito Centro Norte',
                () => navigateTo60(context)),
          ],
        )

        /*StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('ruta').doc('23').snapshots(), 
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text('Error'),
          );
        }
        if(snapshot.connectionState == ConnectionState.active){
          Map<String, dynamic> data = 
          snapshot.data!.data() as Map<String, dynamic>;
          return Card(
             child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                       children: [
                         Image.network(data['img'],
                              width: 100, 
                              height: 100,),
                       SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(data['ruta']),
                            Text(data['nombre']),
                            ],
                        ),
                        Spacer(),
                        GestureDetector(
                           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen())) ,
                            child: Icon(Icons.map)
                        )
                      ],
                        ),
                    ),
          );
          /*return Center(
            child: Text(data['nombre'], 
            style: 
            TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            ),
          );*/
        }

         return Center(
            child: CircularProgressIndicator()
          );

      },
    ),*/

/*StreamBuilder(
        stream: _rutasFirebase!.getAllRutas(),
        builder: (context, AsyncSnapshot snapshot,) {
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                  Text(snapshot.data!.docs[index].get('nombre')), 
                  Image.network(snapshot.data!.docs[index].get('img')),
                  Text(snapshot.data!.docs[index].get('numero')),
                  snapshot.data!.docs[index].get('nombre'),
                );
                /*return Column(
                  children: [
                    Image.network(snapshot.data!.docs[index].get('img')),
                    Text(snapshot.data!.docs[index].get('numero')),
                    Text(snapshot.data!.docs[index].get('nombre')),
                  ]
                );*/
              },
            );
          }else{
            if(snapshot.hasError) {
            return Center (child: Text('Error'),);
            }else{
              return Center (child: CircularProgressIndicator());
            }
          }
        },
      ),*/

        /*FutureBuilder(
          future: getAllRutasList(), 
          builder: ((context, snapshot) {
            if(snapshot.hasData){
                 return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                       children: [
                         Image.network(snapshot.data?[index]['img'],
                              width: 100, 
                              height: 100,),
                       SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(snapshot.data?[index]['numero']),
                            Text(snapshot.data?[index]['nombre']),
                            ],
                        ),
                        Spacer(),
                        GestureDetector(
                           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MapsScreen())) ,
                            child: Icon(Icons.map)
                        )
                      ],
                        ),
                    ),
                  );  
          });
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        )
      
        
        )*/
        );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: _user.imageUrl != null
                    ? NetworkImage(_user.imageUrl!)
                    : NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: _user.name != null
                  ? Text(_user.name!)
                  : Text('Buenas tardes'),
              accountEmail: _user.email != null
                  ? Text(_user.email!)
                  : Text('Bienvenido')),
          ListTile(
            leading: Icon(Icons.person),
            trailing: Icon(Icons.chevron_right),
            title: Text('Perfil'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            leading: Icon(Icons.info),
            trailing: Icon(Icons.chevron_right),
            title: Text('Información'),
            onTap: () => Navigator.pushNamed(context, '/information'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: globalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              globalValues.flagTheme.value = isDarkModeEnabled;
              globalValues().saveValue(isDarkModeEnabled);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Ícono de cerrar sesión
            title: Text('Cerrar sesión'),
            onTap: () {
              logout(); // Llama a la función logout al hacer clic en "Cerrar sesión"
              _handleLogOut();
              _logoutFB();
            },
          )
        ],
      ),
    );
  }

  void _handleLogOut() async {
    await _auth.signOutGoogle();
    Navigator.pushReplacementNamed(context, '/logout');
    setState(() {
      _user.user = _auth.user;
      Navigator.pushNamed(context, '/logout');
    });
  }

  void _handleLogin() async {
    await _auth.signInGoogle();
    setState(() {
      _user.user = _auth.user;
    });
  }

  _logoutFB() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {
      _userData = null;
      _accessToken = null;
      Navigator.pushNamed(context, '/logout');
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

  Card buildCustomCard(
      String imageUrl, String number, String routeName, VoidCallback onTap) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(number),
                Text(routeName),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Icon(Icons.map),
            ),
          ],
        ),
      ),
    );
  }

  void navigateTo23(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreenSanJose()));
  }

  void navigateTo43(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapsScreen()));
  }

  void navigateTo60(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapScreenPinos()));
  }
}
