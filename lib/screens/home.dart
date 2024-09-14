import 'package:hotel_booking/constants/ImportFiles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the tapped index
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
            buildHorizontalList(screenSize),
            const SizedBox(height: 20),
            sectionTitle('Explore Our Rooms', horizontalPadding),
            const SizedBox(height: 10),
            buildRoomList(screenSize),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar(BuildContext context, Size screenSize) {
    return AppBar(
      toolbarHeight: screenSize.height * 0.1,
      automaticallyImplyLeading: false,
      title: Text(
        "Welcome to Simple Stays",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            logout(context);
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  TextButton buildActionButton(String label, Widget targetPage) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Text(label),
    );
  }

  Widget buildHeaderImage(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Homepage.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Padding sectionTitle(String title, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildHorizontalList(Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final roomTypes = ['Standard', 'Premium', 'Luxury', 'Suite'];
          final imagePaths = [
            'assets/images/standardroom.jpg',
            'assets/images/Room-Premium-min.jpg',
            'assets/images/luxuryRoom.jpeg',
            'assets/images/suiteroom.jpg'
          ];

          return Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.04),
            child: RoomCard(
              width: screenSize.width * 0.5,
              imageHeight: screenSize.height * 0.12,
              roomName: '${roomTypes[index]} Room',
              imagePath: imagePaths[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (roomTypes[index]) {
                        case 'Standard':
                          return const StandardBookingPage();
                        case 'Premium':
                          return const PremiumBookingPage();
                        case 'Luxury':
                          return LuxuryBookingPage();
                        case 'Suite':
                          return const SuiteBookingPage();
                        default:
                          return const StandardBookingPage();
                      }
                    },
                  ),
                );
              },
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
      itemCount: 5,
      itemBuilder: (context, index) {
        final roomTypes = ['Standard', 'Premium', 'Luxury', 'Suite', 'Villa'];
        final colors = [
          Colors.orange.shade200,
          const Color.fromARGB(255, 241, 225, 83),
          Colors.cyan.shade300,
          Colors.pink.shade300,
          Colors.purple.shade300
        ];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  switch (roomTypes[index]) {
                    case 'Standard':
                      return const StandardRoomGalleryPage();
                    case 'Premium':
                      return const PremiumRoomGalleryPage();
                    case 'Luxury':
                      return const LuxuryRoomGalleryPage();
                    case 'Suite':
                      return const SuiteRoomGalleryPage();
                    // case 'Villa':
                    //   return const VillaRoomGalleryPage(); // Add this page in your routing
                    default:
                      return const StandardRoomGalleryPage();
                  }
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: screenSize.height * 0.15,
              decoration: BoxDecoration(
                color: colors[index].withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: colors[index].withOpacity(0.6),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${roomTypes[index]} Room',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Book'),
        BottomNavigationBarItem(
            icon: Icon(Icons.contact_page), label: 'Contact'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromARGB(255, 0, 130, 125),
      onTap: _onItemTapped,
    );
  }
}

// Separate reusable RoomCard widget
class RoomCard extends StatelessWidget {
  final double width;
  final double imageHeight;
  final String roomName;
  final String imagePath; // New parameter for the image path
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.width,
    required this.imageHeight,
    required this.roomName,
    required this.imagePath, // Initialize the image path
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath), // Use the image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              roomName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 0, 130, 125),
                backgroundColor: Colors.white,
              ),
              child: const Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}

// Separate reusable RoomListItem widget
class RoomListItem extends StatelessWidget {
  final double width;
  final double height;
  final String roomName;
  final VoidCallback onTap;

  const RoomListItem({
    super.key,
    required this.width,
    required this.height,
    required this.roomName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Placeholder for room image
          Container(
            width: width,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[400], // Replace with actual room image
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    roomName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 130, 125),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
