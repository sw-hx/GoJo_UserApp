import 'package:flutter/material.dart';

/// # coded By [Hala]

class AuthService {
  Future<void> signUp(
    String email,
    String password,
    BuildContext context,
  ) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Sign up pressed with $email")));
  }

  Future<void> signInWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Login pressed with $email")));
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Google login pressed")));
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Facebook login pressed")));
  }

  Future<void> signInWithApple(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Apple login pressed")));
  }
}
