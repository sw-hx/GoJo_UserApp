import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'error in create user with email and password (firebase_auth_service) ${e.toString()}',
      );
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception(e.toString());
      }
    } catch (e) {
      log(
        'error in create user with email and password (firebase_auth_service) ${e.toString()}',
      );
      throw Exception(e.toString());
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'error in sign in with email and password (firebase_auth_service) ${e.toString()}',
      );
      if (e.code == 'invalid-credential') {
        throw Exception('Email or password is incorrect');
      } else {
        throw Exception(e.code);
      }
    } catch (e) {
      log(
        'error in sign in with email and password (firebase_auth_service) ${e.toString()}',
      );
      throw Exception(e.toString());
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      switch (loginResult.status) {
        case LoginStatus.success:
          final accessToken = loginResult.accessToken;
          if (accessToken == null) {
            throw Exception("There is no access token from facebook");
          }

          final OAuthCredential credential = FacebookAuthProvider.credential(
            accessToken.tokenString,
          );

          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(credential);

          print("✅ Facebook Email: ${userCredential.user?.email}");

          return userCredential.user;

        case LoginStatus.cancelled:
          throw Exception("User cancelled the login");

        case LoginStatus.failed:
          throw Exception("Failed to login");

        default:
          throw Exception("Unknown status");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
