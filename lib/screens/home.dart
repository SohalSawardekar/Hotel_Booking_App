import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking/constants/ImportFiles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentIndex = 0;

  final List<String> headerImages = [
    'assets/images/Homepage.jpg',
    'assets/images/HOME1.jpg',
    'assets/images/HOME2.jpg',
    'assets/images/HOME3.jpg',
    'assets/images/HOME4.jpg',
    'assets/images/HOME5.jpg',
  ];

  final List<String> roomTypes = [
    'Standard',
    'Premium',
    'Luxury',
    'Suite',
    'Villa'
  ];

  final List<String> imagePaths = [
    'assets/images/standardroom.jpg',
    'assets/images/Room-Premium-min.jpg',
    'assets/images/luxuryRoom.jpeg',
    'assets/images/suiteroom.jpg',
    'assets/images/villa.jpg',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final pages = [
      const HomeScreen(),
      const ProfilePage(),
      const BookingPage(
        checkInDate: null,
        checkOutDate: null,
        roomType: '',
        totalAmount: 0,
      ),
      const ContactUs(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pages[index]),
    );
  }

  void navigateToBookingPage(String roomType) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        switch (roomType) {
          case 'Standard':
            return const StandardBookingPage();
          case 'Premium':
            return const PremiumBookingPage();
          case 'Luxury':
            return const LuxuryBookingPage();
          case 'Suite':
            return const SuiteBookingPage();
          case 'Villa':
            return const VillaBookingPage();
          default:
            return const StandardBookingPage();
        }
      }),
    );
  }

  void navigateToGalleryPage(String roomType) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        switch (roomType) {
          case 'Standard':
            return const StandardRoomGalleryPage();
          case 'Premium':
            return const PremiumRoomGalleryPage();
          case 'Luxury':
            return const LuxuryRoomGalleryPage();
          case 'Suite':
            return const SuiteRoomGalleryPage();
          case 'Villa':
            return const VillaRoomGalleryPage();
          default:
            return const StandardRoomGalleryPage();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double horizontalPadding = screenSize.width * 0.04;

    return Scaffold(
      appBar: buildAppBar(context, screenSize),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderImage(screenSize),
            const SizedBox(height: 20),
            sectionTitle('Recommended for You', horizontalPadding),
            const SizedBox(height: 20),
            buildRecommendedForYou(screenSize),
            const SizedBox(height: 20),
            sectionTitle('Explore Our Rooms', horizontalPadding),
            const SizedBox(height: 10),
            buildRoomList(screenSize),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context, Size screenSize) {
    return AppBar(
      toolbarHeight: screenSize.height * 0.08,
      backgroundColor: Colors.teal,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Icon(Icons.hotel,
              color: Colors.white, size: screenSize.height * 0.035),
          const SizedBox(width: 1),
          Text(
            "Simple Stays",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              logout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 216, 145, 78),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Log out',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeaderImage(Size screenSize) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: headerImages
              .map((imagePath) => Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: screenSize.height * 0.4,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: headerImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() => _currentIndex = entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.5, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(240, 179, 179, 179),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Padding sectionTitle(String title, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget buildRecommendedForYou(Size screenSize) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: screenSize.height * 0.26, // Reduced height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: roomTypes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.02), // Reduced left padding
            child: Container(
              width: screenSize.width * 0.4, // Reduced width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 200, 200, 201),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    blurRadius: 15,
                    spreadRadius: 2.5,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: screenSize.height * 0.15, // Reduced height
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      image: DecorationImage(
                        image: AssetImage(imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Text(
                          '${roomTypes[index]} Room',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.black
                                : Colors.white, // Change color based on mode
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            navigateToBookingPage(roomTypes[index]);
                          },
                          child: const Text('Book Now'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRoomList(Size screenSize) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: roomTypes.length,
      itemBuilder: (context, index) {
        final colors = [
          Colors.orange.shade100,
          Colors.blue.shade100,
          Colors.green.shade100,
          Colors.purple.shade100,
          Colors.red.shade100,
        ];

        return GestureDetector(
          onTap: () {
            navigateToGalleryPage(roomTypes[index]);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
            padding: EdgeInsets.all(screenSize.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colors[index % colors.length],
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(201, 255, 252, 252).withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: screenSize.width * 0.3,
                  height: screenSize.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        roomTypes[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'View Gallery',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: isDarkMode
          ? Colors.black
          : Colors.white, // Background color changes based on mode
      selectedItemColor:
          isDarkMode ? Colors.white : Colors.black, // Selected item color
      unselectedItemColor:
          isDarkMode ? Colors.white54 : Colors.black54, // Unselected item color
      selectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14, // Set font size for selected labels
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 14, // Set font size for unselected labels
      ),
      showSelectedLabels: true, // Ensure selected labels are always shown
      showUnselectedLabels: true, // Ensure unselected labels are always shown
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28), // Increase icon size
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 28), // Increase icon size
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book, size: 28), // Increase icon size
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail, size: 28), // Increase icon size
          label: 'Contact',
        ),
      ],
    );
  }
}
