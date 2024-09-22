import 'package:flutter/material.dart';

class SuiteRoomGalleryPage extends StatefulWidget {
  const SuiteRoomGalleryPage({super.key});

  @override
  _SuiteRoomGalleryPageState createState() => _SuiteRoomGalleryPageState();
}

class _SuiteRoomGalleryPageState extends State<SuiteRoomGalleryPage> {
  @override
  Widget build(BuildContext context) {
    // List of images for the Suite Room gallery
    final List<String> imageList = [
      'assets/images/STUD1.png',
      'assets/images/STUD2.png',
      'assets/images/STUD2.png',
      'assets/images/STUD4.png',
      'assets/images/STUD5.png',
      'assets/images/STUD6.png', // Add more images as needed
    ];

    const String description =
        'Suite offering separate living and sleeping areas with top-tier amenities.';
    const String bedDetails = '1 King Size Bed + 1 Single Bed';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Kitchenette';
    const String extraBedCharges = '₹1200 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suite Room Gallery'),
        backgroundColor: Colors.deepPurple, // A luxurious color for the suite
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel with Multiple Images
            SizedBox(
              height: 250, // Adjust the height as needed
              child: PageView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      child: Image.asset(
                        imageList[index],
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width *
                            0.9, // Adjust width
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
                        'Suite Room',
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
