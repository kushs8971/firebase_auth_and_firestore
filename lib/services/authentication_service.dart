import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {

  final BuildContext context;
  AuthenticationService(this.context);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  get user => _auth.currentUser;

  Future<User?> signInWithGoogle(BuildContext context) async {
    User? user;

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        user = userCredential.user;
        saveUserToSharedPreferences();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
        print(e);
        return null;
      }
    } else {
      return null;
    }
    return user;
  }

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveUserToSharedPreferences();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Email already in Use!'
          ),
          behavior: SnackBarBehavior.floating, // Use floating behavior
          margin: EdgeInsets.fromLTRB(20,0,20,50),
        ));
      }
      return null;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      saveUserToSharedPreferences();
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No user found for that email!'
          ),
          behavior: SnackBarBehavior.floating, // Use floating behavior
          margin: EdgeInsets.fromLTRB(20,0,20,50),
        ));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Wrong password provided for that user!'
          ),
          behavior: SnackBarBehavior.floating, // Use floating behavior
          margin: EdgeInsets.fromLTRB(20,0,20,50),
        ));
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  saveUserToSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final currentUser = _auth.currentUser;
    if(currentUser==null){
      return;
    }
    await sharedPreferences.setString('userId', currentUser.uid);
  }

  //SIGN OUT METHOD
  Future signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if(_auth.currentUser!=null){
      await _auth.signOut();
    }
    if(await googleSignIn.isSignedIn()){
      print('DISCONNECTING GOOGLE');
      await googleSignIn.disconnect();
    }
    await sharedPreferences.clear();
    print('sign-out successful');
  }
}

