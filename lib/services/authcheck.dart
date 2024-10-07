import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/screens/home.dart';
import 'package:hotel_booking/screens/authentication/login.dart';

import '../constants/ImportFiles.dart';

// Wrapper to check the authentication status
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the snapshot has data, the user is logged in
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User is not logged in, go to login page
            return const LoginPage();
          } else {
            // User is logged in, go to home page
            return const WelcomePopUp();
          }
        } else {
          // Show loading while checking authentication status
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// WelcomePopUp Class with Animation and Fade-out Effect
class WelcomePopUp extends StatefulWidget {
  const WelcomePopUp({super.key});

  @override
  _WelcomePopUpState createState() => _WelcomePopUpState();
}

class _WelcomePopUpState extends State<WelcomePopUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInFadeOut;
  late Animation<double> _scaleTransition;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _scaleTransition = Tween<double>(begin: 0.8, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((value) {
      // After animation completes, navigate to Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          // Gradient background for luxury feel
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D324D), Color(0xFF7F5A83)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: FadeTransition(
              opacity: _fadeInFadeOut,
              child: ScaleTransition(
                scale: _scaleTransition,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circular glowing effect behind text
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            blurRadius: 100,
                            spreadRadius: 30,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "WELCOME TO",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "SIMPLE STAYS",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Tagline for a luxurious appeal
                    Text(
                      "Luxury. Comfort. Affordability.",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.022,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Welcome message
                    Text(
                      "Your dream stay awaits...",
                      style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.022,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
