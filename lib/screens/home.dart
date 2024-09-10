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
      const BookingPage(roomType: 'null'),
      const ContactUs(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pages[index]),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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

  AppBar buildAppBar(BuildContext context, screenSize) {
    return AppBar(
      toolbarHeight: screenSize.height * 0.1,
      automaticallyImplyLeading: false,
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Search Hotels',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            logout(context);
          }, // Call the logout function
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
      height: screenSize.height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => buildRoomCard(screenSize, index),
      ),
    );
  }

  Padding buildRoomCard(Size screenSize, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: RoomCard(
        width: screenSize.width * 0.4,
        imageHeight: screenSize.height * 0.12,
        roomName: 'Room ${index + 1}',
        onTap: () {
          // Add booking functionality
        },
      ),
    );
  }

  Widget buildRoomList(Size screenSize) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RoomListItem(
          width: screenSize.width * 0.3,
          height: screenSize.height * 0.15,
          roomName: 'Room ${index + 1}',
          onTap: () {
            // Add booking functionality
          },
        ),
      ),
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
  final VoidCallback onTap;

  const RoomCard({
    required this.width,
    required this.imageHeight,
    required this.roomName,
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
              color: Colors.grey[400], // Placeholder for room image
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
              child: const Text('Book Now'),
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 0, 130, 125),
                backgroundColor: Colors.white,
              ),
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
                    child: const Text('Book'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 130, 125),
                      backgroundColor: Colors.white,
                    ),
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
