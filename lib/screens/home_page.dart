import "dart:ui";
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:hotel_management/screens/feedback_page.dart";
import "booking_page.dart";
import "hotel_info_page.dart";
import '../auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(
              child: Text(
            'Hotel Booking System',
            style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w700),
          )),
          backgroundColor: const Color.fromARGB(255, 85, 60, 104),
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(224, 54, 7, 88),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: const Color.fromARGB(174, 112, 71, 142)),
                  child: Text(
                    'Book Room',
                    style: GoogleFonts.poppins(
                        color: const Color.fromARGB(237, 255, 255, 255),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HotelInfoPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: const Color.fromARGB(174, 112, 71, 142)),
                  child: Text(
                    'About Us',
                    style: GoogleFonts.poppins(
                        color: const Color.fromARGB(237, 255, 255, 255),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: const Color.fromARGB(174, 112, 71, 142)),
                  child: Text(
                    'Feedback',
                    style: GoogleFonts.poppins(
                        color: const Color.fromARGB(237, 255, 255, 255),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    backgroundColor: const Color.fromARGB(174, 112, 71, 142),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(237, 255, 255, 255),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
