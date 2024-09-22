import 'package:flutter/material.dart';

class LuxuryRoomGalleryPage extends StatefulWidget {
  const LuxuryRoomGalleryPage({super.key});

  @override
  _LuxuryRoomGalleryPageState createState() => _LuxuryRoomGalleryPageState();
}

class _LuxuryRoomGalleryPageState extends State<LuxuryRoomGalleryPage> {
  @override
  Widget build(BuildContext context) {
    // Multiple images to be shown in the gallery
    final List<String> imageList = [
      'assets/images/LX1.png',
      'assets/images/LX2.png',
      'assets/images/LX3.png',
      'assets/images/LX4.png',
      'assets/images/LX5.png', // Add more images as needed
    ];

    const String description =
        'Luxury room with high-end finishes, designed for comfort and relaxation.';
    const String bedDetails = '2 Queen Size Beds';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Jacuzzi';
    const String extraBedCharges = '₹1000 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luxury Room Gallery'),
        backgroundColor: Colors.indigoAccent, // Stylish color for luxury feel
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel with multiple images
            SizedBox(
              height: 250, // Adjusted height for larger image display
              child: PageView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          15), // Rounded corners for images
                      child: Image.asset(
                        imageList[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Room Details Section with Card Layout
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Luxury Room',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bed Type: $bedDetails',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Amenities: $amenities',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Extra Bed Charges: $extraBedCharges',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
