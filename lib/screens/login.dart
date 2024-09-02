import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/pexels-pixabay-206359.jpg"),
            fit: BoxFit
                .cover, // or other options like BoxFit.fill, BoxFit.contain
          ),
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.red),
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          )
        ]),
      ),
    ));
  }
}
