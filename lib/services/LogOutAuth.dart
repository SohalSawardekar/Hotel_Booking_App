// Initialize GoogleSignIn instance
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

// Logout function to handle Firebase and Google sign-out
Future<void> logout(BuildContext context) async {
  try {
    // Sign out from Firebase
    await FirebaseAuth.instance.signOut();

    // Check if the user is signed in with Google
    if (await _googleSignIn.isSignedIn()) {
      // Sign out from Google
      await _googleSignIn.signOut();
    }

    // After signing out, navigate to the login page
    Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    // Handle logout errors here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error signing out: $e')),
    );
  }
}
