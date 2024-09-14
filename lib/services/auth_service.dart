import 'package:hotel_booking/constants/ImportFiles.dart';

class AuthService {
  // Method for logging in with email and password
  static Future<void> loginWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // Attempt to sign in the user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Successfully signed in
      // Navigate to the home page or other protected page
      Navigator.pushReplacementNamed(
          context, '/home'); // Update this with your route
    } on FirebaseAuthException catch (e) {
      // Handle errors from Firebase authentication
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // Handle other types of exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Method for registering with email and password
  static Future<void> registerWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // Register the user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful registration, create user document in Firestore
      FirestoreService firestoreService = FirestoreService();
      await firestoreService.createUserInFirestore(userCredential.user);

      // Navigate to home page after successful registration
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // Handle other exceptions
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}
