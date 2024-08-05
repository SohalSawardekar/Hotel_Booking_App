import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class HotelInfoPage extends StatelessWidget {
  const HotelInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Information'),
        titleTextStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
        elevation: 0,
        backgroundColor: Colors.amber[800],
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber[100],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Center(
                      child: Text(
                    'Welcome to Serene Valley Resort!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  )),
                  const SizedBox(height: 20),
                  const Text(
                      'Our Swimming Pool: Dive into our crystal clear swimming pool, where you can relax and rejuvenate while enjoying the panoramic mountain views.',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78))),
                  const SizedBox(height: 20),
                  const Text(
                    'Huge Lawns: Stroll through our expansive, lush green lawns. Perfect for morning walks, yoga sessions, or simply soaking up the tranquility.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Kids Playing Area: We have a dedicated kids playing area, ensuring our young guests have as much fun as the adults. Safe and entertaining, it\'s a paradise for children.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Mountains and Beautiful Sceneries: Experience breathtaking views of the surrounding mountains and landscapes. Every corner of our resort is a picture-perfect scene, ideal for photography enthusiasts.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Luxurious Accommodations: Our rooms and suites are designed to provide the utmost comfort. With modern amenities and elegant decor, each room offers a serene retreat after a day of exploration.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gourmet Dining: Savor delectable dishes at our in-house restaurant, where our chefs prepare a variety of cuisines using fresh, locally sourced ingredients.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Spa and Wellness: Pamper yourself at our spa with a range of treatments designed to relax and rejuvenate your body and mind.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Adventure Activities: For the thrill-seekers, we offer various adventure activities like trekking, mountain biking, and guided nature walks.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Event Spaces: Our resort features versatile event spaces perfect for weddings, corporate retreats, and other special occasions. Our dedicated team will ensure your event is a grand success.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Why Choose Serene Valley Resort?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'At Serene Valley Resort, we believe in creating unforgettable experiences. Whether you\'re here for a family vacation, a romantic getaway, or a solo adventure, our resort offers something for everyone. With our impeccable service and stunning natural surroundings, we strive to make your stay truly special.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Book your stay with us and immerse yourself in the serene beauty and luxurious comfort of Serene Valley Resort. We look forward to welcoming you!',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 78, 78, 78)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement more info functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[800],
                    ),
                    child: Text('More Information',
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
