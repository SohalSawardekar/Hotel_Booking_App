import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to check if a user exists and create a new user if not
  Future<void> createUserInFirestore([User? user]) async {
    // Get the currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the 'users' collection in Firestore
      DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      // Check if the user document already exists
      DocumentSnapshot userDoc = await userRef.get();

      if (!userDoc.exists) {
        // If the user does not exist, create a new document with user info
        await userRef.set({
          'email': user.email,
          'name': user.displayName, // Handle if displayName is null
          'mobileNo': user.phoneNumber, // Handle if displayName is null
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'bookings': [], // Initialize an empty list for bookings
          'preferences': {}, // Initialize an empty map for user preferences
        });
        print('New user document created for ${user.email}');
      } else {
        // If the user exists, update the last login time
        await userRef.update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
        print('User already exists. Last login time updated for ${user.email}');
      }
    }
  }

  // Function to get user data
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print('User document does not exist for UID: $uid');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Function to update user preferences
  Future<void> updateUserPreferences(
      String uid, Map<String, dynamic> preferences) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'preferences': preferences,
      });
      print('User preferences updated for UID: $uid');
    } catch (e) {
      print('Error updating user preferences: $e');
    }
  }

  // Function to add a new booking
  Future<void> addBooking(String uid, Map<String, dynamic> booking) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(uid);
      await userRef.update({
        'bookings': FieldValue.arrayUnion([booking]),
      });
      print('New booking added for UID: $uid');
    } catch (e) {
      print('Error adding booking: $e');
    }
  }
}
