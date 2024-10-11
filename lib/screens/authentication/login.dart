import 'package:hotel_booking/constants/ImportFiles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool _isVisible = false; // Start with password hidden

  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Form(
            key: _formKey, // Wrap with Form widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.2),
                Text(
                  "WELCOME",
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: '',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Basic email validation
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                TextFormField(
                  controller: passwordController,
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: '',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      String? email = await showDialog(
                        context: context,
                        builder: (context) => ForgotPasswordDialog(),
                      );

                      if (email != null && email.isNotEmpty) {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Password reset email sent')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate the form before login
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, log in
                        await AuthService.loginWithEmailAndPassword(
                          context,
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        // Show Welcome Popup after successful login
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomePopUp()),
                        );
                      } else {
                        // If the form is not valid, show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please fill out all fields correctly'),
                          ),
                        );
                      }
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
                          color: const Color.fromRGBO(255, 255, 255, 1),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialLoginButton(
                      imagePath: 'assets/icons/Google__G__logo.png',
                      loginMethod: signInWithGoogle,
                      iconSize: screenHeight * 0.03,
                    ),
                    SizedBox(width: screenWidth * 0.05),
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
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
