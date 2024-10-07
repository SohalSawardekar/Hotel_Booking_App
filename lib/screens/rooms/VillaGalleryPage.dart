import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking/constants/ImportFiles.dart';

class VillaRoomGalleryPage extends StatefulWidget {
  const VillaRoomGalleryPage({super.key});

  @override
  _VillaRoomGalleryPageState createState() => _VillaRoomGalleryPageState();
}

class _VillaRoomGalleryPageState extends State<VillaRoomGalleryPage> {
  final List<String> imageList = [
    'assets/images/Villa1.jpeg',
    'assets/images/Villa2.jpeg',
    'assets/images/Villa3.jpeg',
    'assets/images/Villa4.jpeg',
    'assets/images/Villa5.jpeg',
  ];

  int _currentImageIndex = 0;

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;

    const String description =
        'Luxurious villa with spacious rooms, private pool, and a serene atmosphere.';
    const String bedDetails = '2 King Size Beds';
    const List<String> amenitiesList = [
      'Private Pool',
      'Free Wi-Fi',
      'TV',
      'Mini-Bar',
      'Bathtub',
      'Personal Butler',
    ];
    const String extraBedCharges = '₹1,000 per night';

    return Scaffold(
      appBar: AppBar(
        title: Text('Villa Room Gallery',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.grey.shade900, Colors.black]
                : [Colors.white, Colors.grey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Carousel with Indicator
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: imageList.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Hero(
                            tag: imagePath,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDarkMode
                                        ? Colors.black.withOpacity(0.4)
                                        : Colors.teal.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // Indicator Dots
                  Positioned(
                    bottom: 15,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _currentImageIndex = entry.key;
                          }),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 4.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == entry.key
                                  ? Colors.teal
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Room Details Section with Glowing Text and Gradient Background
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 15,
                  shadowColor: isDarkMode
                      ? Colors.black.withOpacity(0.4)
                      : Colors.teal.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDarkMode
                            ? [Colors.grey.shade900, Colors.black]
                            : [Colors.white, Colors.grey.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.teal.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Glowing text for room title
                          Text(
                            'Villa',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.teal,
                              shadows: [
                                Shadow(
                                  color: Colors.teal.withOpacity(0.8),
                                  blurRadius: 15,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color:
                                  isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Bed details with icons
                          Row(
                            children: [
                              Icon(Icons.bed,
                                  color: isDarkMode
                                      ? Colors.orangeAccent
                                      : Colors.grey),
                              const SizedBox(width: 10),
                              Text(
                                'Bed Type: $bedDetails',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? Colors.orangeAccent
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Amenities row with icons (formatted to prevent overflow)
                          Column(
                            children: [
                              for (var i = 0; i < amenitiesList.length; i += 2)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.check_circle_outline,
                                            color: isDarkMode
                                                ? Colors.orangeAccent
                                                : Colors.grey),
                                        const SizedBox(width: 10),
                                        Text(
                                          amenitiesList[i],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: isDarkMode
                                                ? Colors.orangeAccent
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (i + 1 < amenitiesList.length)
                                      Row(
                                        children: [
                                          Icon(Icons.check_circle_outline,
                                              color: isDarkMode
                                                  ? Colors.orangeAccent
                                                  : Colors.grey),
                                          const SizedBox(width: 10),
                                          Text(
                                            amenitiesList[i + 1],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isDarkMode
                                                  ? Colors.orangeAccent
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Extra bed charges row
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: isDarkMode
                                      ? Colors.orangeAccent
                                      : Colors.grey),
                              const SizedBox(width: 10),
                              Text(
                                'Extra Bed Charges: $extraBedCharges',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDarkMode
                                      ? Colors.orangeAccent
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sparkling Decoration (Optional, remove if not needed)
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.teal.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.5, 1],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Villa Stays',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
