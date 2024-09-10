import 'package:hotel_booking/constants/ImportFiles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Samarth Kamat";
  String userEmail = "Samarthkamat80@gmail.com";
  String userPhone = "+91 7709086986";

  List<Map<String, String>> bookingHistory = [
    {"hotel": "Hotel Taj", "date": "2024-09-01", "status": "Completed"},
    {"hotel": "Hotel Oberoi", "date": "2024-08-30", "status": "Cancelled"},
    {"hotel": "Hotel Marriott", "date": "2024-08-25", "status": "Completed"},
  ];

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
      body: SingleChildScrollView(
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
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
                      ),
                      Text(
                        userPhone,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color),
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
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    title: Text(
                      bookingHistory[index]['hotel']!,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    subtitle: Text(
                      'Date: ${bookingHistory[index]['date']}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    trailing: Text(
                      'Status: ${bookingHistory[index]['status']}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color),
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
}
