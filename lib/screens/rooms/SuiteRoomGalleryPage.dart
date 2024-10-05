import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/ImportFiles.dart';

class SuiteRoomGalleryPage extends StatefulWidget {
  const SuiteRoomGalleryPage({super.key});

  @override
  _SuiteRoomGalleryPageState createState() => _SuiteRoomGalleryPageState();
}

class _SuiteRoomGalleryPageState extends State<SuiteRoomGalleryPage> {
  final List<String> imageList = [
    'assets/images/STUD1.png',
    'assets/images/STUD2.png',
    'assets/images/STUD3.png',
    'assets/images/STUD4.png',
    'assets/images/STUD5.png',
    'assets/images/STUD6.png', // Add more images as needed
  ];

  int _currentImageIndex = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;

    const String description =
        'Suite offering separate living and sleeping areas with top-tier amenities.';
    const String bedDetails = '1 King Size Bed + 1 Single Bed';
    const List<String> amenitiesList = [
      'Free Wi-Fi',
      'Smart TV',
      'Mini-Bar',
      'Kitchenette',
      'Room Service'
    ];
    const String extraBedCharges = '₹1200 per night';

    return Scaffold(
      appBar: AppBar(
        title: Text('Suite Room Gallery',
            style: GoogleFonts.poppins(
              color: isDarkMode ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.deepPurpleAccent,
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
                                        : Colors.deepPurpleAccent
                                            .withOpacity(0.2),
                                    blurRadius: 15,
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
                                  ? Colors.deepPurpleAccent
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.deepPurpleAccent
                                          .withOpacity(0.7),
                                  blurRadius: 4,
                                ),
                              ],
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
                      : Colors.deepPurpleAccent.withOpacity(0.4),
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
                        color: Colors.deepPurpleAccent.withOpacity(0.4),
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
                            'Suite Room',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepPurpleAccent,
                              shadows: [
                                Shadow(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.6),
                                  blurRadius: 10,
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
                                  fontSize: 14,
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

              // Sparkling Decoration
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.deepPurpleAccent.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.5, 1],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Suite Stays',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
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
