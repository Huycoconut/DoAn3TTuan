import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService { 
  FirebaseAuth _auth = FirebaseAuth.instance;
  //dang ky tai khoan
  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e){}
    return null;
  }
  //dang nhap
  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }
    catch(e){}
    return null;
  }
}