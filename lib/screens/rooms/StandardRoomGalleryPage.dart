import 'package:flutter/material.dart';

class StandardRoomGalleryPage extends StatefulWidget {
  const StandardRoomGalleryPage({super.key});

  @override
  _StandardRoomGalleryPageState createState() =>
      _StandardRoomGalleryPageState();
}

class _StandardRoomGalleryPageState extends State<StandardRoomGalleryPage> {
  @override
  Widget build(BuildContext context) {
    // Multiple images for the standard room
    final List<String> imageList = [
      'assets/images/ST1.png',
      'assets/images/ST2.png',
      'assets/images/ST3.png',
      'assets/images/ST4.png',
    ];

    const String description =
        'Comfortable standard room with basic amenities and a cozy feel.';
    const String bedDetails = '1 King Size Bed';
    const String amenities = 'Free Wi-Fi, TV, Mini-Bar, Shower';
    const String extraBedCharges = '₹500 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Room Gallery'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Carousel with Multiple Images
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
                        'Standard Room',
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
