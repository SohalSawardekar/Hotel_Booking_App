
import 'package:hotel_booking/constants/ImportFiles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  List<Map<String, String>> bookingHistory = [];

  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      // Get the current user UID
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;

        // Fetch user details from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(uid).get();

        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          setState(() {
            userName = userData['name'] ?? 'No Name';
            userEmail = userData['email'] ?? 'No Email';
            userPhone = userData['phone'] ?? 'No Phone';
            bookingHistory = List<Map<String, String>>.from(
                userData['bookings'].map((booking) => {
                      "hotel": booking['hotel'],
                      "date": booking['date'],
                      "status": booking['status'],
                    }));
          });
        } else {
          // Handle if user does not exist in Firestore
          setState(() {
            userName = 'User not found';
          });
        }
      }
    } catch (e) {
      // Handle Firestore fetch error
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeNotifier>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Details Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                              'assets/images/profile_avatar.png'), // Add your avatar image
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              userEmail,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                            ),
                            Text(
                              userPhone,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Booking History Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Booking History',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingHistory.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: Icon(Icons.hotel,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                          title: Text(
                            bookingHistory[index]['hotel']!,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color),
                          ),
                          subtitle: Text(
                            'Date: ${bookingHistory[index]['date']}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                          ),
                          trailing: Text(
                            'Status: ${bookingHistory[index]['status']}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  // Settings Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.language,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    title: const Text('Language'),
                    onTap: () {
                      // Language change logic
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    title: const Text('Notifications'),
                    onTap: () {
                      // Notification settings logic
                    },
                  ),
                  const Divider(),
                  // Logout Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        logout(context);
                      }, // Call the logout function
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void logout(BuildContext context) {
    _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
