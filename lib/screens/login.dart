import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/reuse_code/auth_service.dart';
import 'package:hotel_booking/reuse_code/custom_text_field.dart';
import 'package:hotel_booking/reuse_code/loginauth.dart';
import 'package:hotel_booking/reuse_code/social_login_button.dart';
import 'package:hotel_booking/screens/register.dart';
import 'package:hotel_booking/constants/data.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.07),
              Text(
                "WELCOME",
                style: GoogleFonts.poppins(
                  fontSize: screenHeight * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              CustomTextField(
                controller: emailController,
                labelText: "Email",
                hintText: '',
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomTextField(
                controller: passwordController,
                labelText: "Password",
                isPassword: true,
                hintText: '',
              ),
              SizedBox(height: screenHeight * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password logic
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (newValue) {}),
                  const Text("Remember Me"),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    AuthService.loginWithEmailAndPassword(
                      context,
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        fontSize: screenHeight * 0.025,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Or With")],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons
                children: [
                  SocialLoginButton(
                    imagePath: 'assets/icons/Google__G__logo.png',
                    loginMethod: signInWithGoogle,
                    iconSize: screenHeight * 0.03,
                  ),
                  SizedBox(
                      width:
                          screenWidth * 0.05), // Reduce spacing between buttons
                  SocialLoginButton(
                    imagePath: 'assets/icons/Apple_logo_black.png',
                    loginMethod: signInWithApple,
                    iconSize: screenHeight * 0.03,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
