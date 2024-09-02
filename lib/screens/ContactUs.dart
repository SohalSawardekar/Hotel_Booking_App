import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_booking/constants/data.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // TextEditingController to capture the input from the Name TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Method to launch the dialer
  void _launchDialer(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Method to launch the email client
  void _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': 'Contact',
        'body': 'Hello',
      },
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print('Could not launch email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top bar
              Container(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 5),
                    BackButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 228, 228, 228)),
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(2)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(flex: 15),
                    InkWell(
                      onTap: () => _launchEmail(
                          emailAddress), // Launch email client on tap
                      child: Image.asset(
                        "assets/icons/icons8-email-50.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const Spacer(flex: 40),
                    InkWell(
                      onTap: () => _launchDialer(
                          telephoneNumber), // Launch dialer on tap
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/icons8-phone-50.png",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                              width: 8), // Space between icon and text
                          Text(telephoneNumber),
                        ],
                      ),
                    ),
                    const Spacer(flex: 20),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Main body
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      "Contact Us",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // Name
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Name",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: GoogleFonts.poppins(),
                        border: InputBorder.none,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black, // Border color
                            width: 1.5, // Border width
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Border color when focused
                            width: 2.0, // Border width when focused
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),

                    // Email
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Email",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextField(
                      controller:
                          _emailController, // This should be a separate controller for email
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: GoogleFonts.poppins(),
                        border: InputBorder.none,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black, // Border color
                            width: 1.5, // Border width
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Border color when focused
                            width: 2.0, // Border width when focused
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),

                    // Message
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        "Message",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    TextField(
                      controller:
                          _messageController, // This should be a separate controller for message
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        hintStyle: GoogleFonts.poppins(),
                        border: InputBorder.none,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black, // Border color
                            width: 1.5, // Border width
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue, // Border color when focused
                            width: 2.0, // Border width when focused
                          ),
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),

                    // Submit button
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromRGBO(
                                    43, 43, 43, 1)), // Background color
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 50.0)), // Padding
                            textStyle: WidgetStateProperty.all<TextStyle>(
                              GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold), // Text style
                            ),
                          ),
                          onPressed: () {
                            // Define the action for the button press here
                          },
                          child: Text("Send",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)), // Button text
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed to free up resources
    _nameController.dispose();
    super.dispose();
  }
}
