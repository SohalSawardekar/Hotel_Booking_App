import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking/reuse_code/loginauth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controllers to capture user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle login
  Future<void> _login(BuildContext context) async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());

      // If login is successful, navigate to the next screen
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle different error codes and show appropriate messages
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      // Show error message in a dialog or a snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.08), // Padding based on screen width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.05), // Top spacing
              Text(
                "WELCOME",
                style: TextStyle(
                  fontSize: screenHeight * 0.04, // Responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Space between fields
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(
                      Icons.visibility_off), // Password visibility icon
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password logic here
                  },
                  child: const Text("Forgot Password?"),
                ),
              ),
              // Remember Me Checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true, // Default value, change as needed
                    onChanged: (newValue) {
                      // Handle checkbox state change
                    },
                  ),
                  const Text("Remember Me"),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              // Login Button
              SizedBox(
                width: screenWidth * 0.8, // Responsive button width
                height: screenHeight * 0.06, // Responsive button height
                child: ElevatedButton(
                  onPressed: () {
                    _login(context); // Pass the context to the _login function
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.teal, // Button color
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: screenHeight * 0.025),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Or With"),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          var message = 'An error occurred. Please try again.';
                          // Show error message in a dialog or a snackbar
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                      iconAlignment: IconAlignment.end,
                      icon: Image.asset(
                        'assets/icons/Google__G__logo.png', // Add your Google icon here
                        height: screenHeight * 0.03,
                      ),
                      label: const Text(""),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.grey), // Border for the button
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        User? user = await signInWithApple();
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          var message = 'An error occurred. Please try again.';
                          // Show error message in a dialog or a snackbar
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                      iconAlignment: IconAlignment.end,
                      icon: Image.asset(
                        'assets/icons/Apple_logo_black.png', // Add your Microsoft icon here
                        height: screenHeight * 0.03,
                      ),
                      label: const Text(""),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
