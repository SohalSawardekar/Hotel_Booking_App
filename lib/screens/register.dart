import 'package:hotel_booking/constants/ImportFiles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.07),
                Text(
                  'Create an account',
                  style: GoogleFonts.poppins(
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                CustomTextField(
                  labelText: 'Email Address',
                  controller: _emailController,
                  hintText: '',
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  labelText: 'Phone Number',
                  hintText: '+91 Enter your phone number',
                  controller: _phonenoController,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  labelText: 'Password',
                  isPassword: true,
                  hintText: 'Please Enter Your Password',
                  controller: _passwordController,
                ),
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  labelText: 'Confirm Password',
                  isPassword: true,
                  hintText: 'Confirm Your Password',
                  controller: _confirmpasswordController,
                ),
                SizedBox(height: screenHeight * 0.01),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Checkbox(
                        //   value: false,
                        //   onChanged: (value) {
                        //     // Handle checkbox change
                        //   },
                        // ),
                        // Text(
                        //   'Remember Me',
                        //   style: GoogleFonts.poppins(),
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.06,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          fontSize: screenHeight * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Or With',
                  style: GoogleFonts.poppins(),
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
                SizedBox(height: screenHeight * 0.05),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmpasswordController.text.trim();

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    try {
      await AuthService.registerWithEmailAndPassword(
          context, email, password); // Ensure the method name matches
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileInfoPage()),
      );
    } catch (e) {
      _showError('An error occurred. Please try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
