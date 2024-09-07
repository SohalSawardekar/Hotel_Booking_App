import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/screens/home.dart';
import 'package:hotel_booking/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD0UUpZv7VaMKMVmQ_xYe8okuZKPYYQG-Y",
      authDomain: "hotel-booking-f1555.firebaseapp.com",
      projectId: "hotel-booking-f1555",
      storageBucket: "hotel-booking-f1555.appspot.com",
      messagingSenderId: "253423276546",
      appId: "1:253423276546:android:9be659fc67f1bf805f4d1b",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hotel Booking",
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // Set initial route to LoginPage page
        '/home': (context) => HomeScreen(),
        // Add other routes here if needed
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => LoginPage()); // or any other default route
      },
    );
  }
}
