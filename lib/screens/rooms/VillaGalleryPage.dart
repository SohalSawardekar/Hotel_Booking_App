import 'package:flutter/material.dart';

class VillaRoomGalleryPage extends StatefulWidget {
  const VillaRoomGalleryPage({super.key});

  @override
  _VillaRoomGalleryPageState createState() => _VillaRoomGalleryPageState();
}

class _VillaRoomGalleryPageState extends State<VillaRoomGalleryPage> {
  @override
  Widget build(BuildContext context) {
    // Multiple images for the villa room
    final List<String> imageList = [
      'assets/images/Villa1.jpeg',
      'assets/images/Villa2.jpeg',
      'assets/images/Villa3.jpeg',
      'assets/images/Villa4.jpeg',
      'assets/images/Villa5.jpeg',
    ];

    const String description =
        'Luxurious villa with spacious rooms, private pool, and a serene atmosphere.';
    const String bedDetails = '2 King Size Beds';
    const String amenities =
        'Private Pool, Free Wi-Fi, TV, Mini-Bar, Bathtub, Personal Butler';
    const String extraBedCharges = '₹1,000 per night';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Villa Room Gallery'),
        backgroundColor: Colors.teal,
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
                        'Villa Room',
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
