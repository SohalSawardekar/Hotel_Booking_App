import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 103, 103, 0.8),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/pexels-pixabay-206359.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.3, // 40% of screen height
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 103, 103, 0.8),
                ),
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: screenHeight * 0.04, // 4% of screen height
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ),
              // You can add more widgets below with similar responsive techniques
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 1)),
                    color: Color.fromRGBO(149, 149, 149, 0.698),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          screenWidth * 0.05), // 5% of screen width
                      child: const TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(162, 162, 162, 0.694),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          labelText: 'Username',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          screenWidth * 0.05), // 5% of screen width
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(162, 162, 162, 0.694),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015, // 2% of screen height
                    horizontal: screenWidth * 0.15, // 30% of screen width
                  ),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.025, // 2.5% of screen height
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
