// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   // Controllers to capture user input
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Function to handle login
//   Future<void> _login() async {
//     try {
//       // Attempt to sign in with email and password
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//               email: _emailController.text.trim(),
//               password: _passwordController.text.trim());

//       // If login is successful, navigate to the next screen
//       Navigator.pushReplacementNamed(context, '/home');
//     } on FirebaseAuthException catch (e) {
//       // Handle different error codes and show appropriate messages
//       String message;
//       if (e.code == 'user-not-found') {
//         message = 'No user found for that email.';
//       } else if (e.code == 'wrong-password') {
//         message = 'Wrong password provided.';
//       } else {
//         message = 'An error occurred. Please try again.';
//       }
//       // Show error message in a dialog or a snackbar
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(message)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get screen size
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(255, 103, 103, 0.8),
//       ),
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/pexels-pixabay-206359.jpg"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: screenHeight * 0.3,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Color.fromRGBO(255, 103, 103, 0.8),
//                 ),
//                 child: Text(
//                   "Login",
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w600,
//                     fontSize: screenHeight * 0.04,
//                     color: const Color.fromRGBO(255, 255, 255, 1),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               Container(
//                 width: screenWidth * 0.85,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color.fromRGBO(255, 255, 255, 1)),
//                     color: const Color.fromRGBO(149, 149, 149, 0.698),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(screenWidth * 0.05),
//                       child: TextField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Color.fromRGBO(162, 162, 162, 0.694),
//                           border: OutlineInputBorder(),
//                           labelStyle: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(255, 255, 255, 1)),
//                           labelText: 'Email',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(screenWidth * 0.05),
//                       child: TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           filled: true,
//                           fillColor: Color.fromRGBO(162, 162, 162, 0.694),
//                           border: OutlineInputBorder(),
//                           labelStyle: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               color: Color.fromRGBO(255, 255, 255, 1)),
//                           labelText: 'Password',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               ElevatedButton(
//                 onPressed: _login, // Call the login function
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                     vertical: screenHeight * 0.015,
//                     horizontal: screenWidth * 0.15,
//                   ),
//                   backgroundColor: const Color.fromRGBO(255, 255, 255, 0.8),
//                 ),
//                 child: Text(
//                   'Login',
//                   style: GoogleFonts.poppins(
//                     fontSize: screenHeight * 0.025,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of controllers when the widget is disposed
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      // Scaffold needs to be returned from the build method
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
                      onPressed: () {
                        // Google login logic
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
                      onPressed: () {
                        // Microsoft login logic
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
