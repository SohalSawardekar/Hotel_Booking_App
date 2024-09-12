import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'FirestoreService.dart';

Future<User?> signInWithGoogle() async {
  try {
    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // If the user cancels the sign-in
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase using the Google credential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    
    // If sign-in is successful, store the user data in Firestore
    if (userCredential.user != null) {
      FirestoreService firestoreService = FirestoreService();
      await firestoreService.createUserInFirestore();
    }
    
    return userCredential.user;
  } catch (e) {
    print('Google sign-in error: $e');
    return null;
  }
}

Future<User?> signInWithApple() async {
  try {
    // Generate a nonce for the Apple authentication request
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Trigger the Apple authentication flow
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an OAuth credential for Firebase using Apple ID
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    
    // If sign-in is successful, store the user data in Firestore
    if (userCredential.user != null) {
      FirestoreService firestoreService = FirestoreService();
      await firestoreService.createUserInFirestore();
    }
    
    return userCredential.user;
  } catch (e) {
    print('Apple sign-in error: $e');
    return null;
  }
}

// Helper function to generate a nonce
String generateNonce([int length = 32]) {
  final random = Random.secure();
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

// Helper function to compute the SHA-256 hash
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
