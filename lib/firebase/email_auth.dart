import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:enrutatec/model/github.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static const String CLIENT_ID = "1909009eb9d726bcead9";
  static const String CLIENT_SECRET = "821e85e421bc3c9be90e28acde837e9b4fe90507";

  Future<bool> createUser(
      {required String emailUser, required String pwdUser}) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: emailUser, password: pwdUser);
      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateUser({required String emailUser, required String pwdUser}) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: emailUser, password: pwdUser);
      if (credentials.user!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  Future signOut() async {
    auth.signOut();
    }
  
}
