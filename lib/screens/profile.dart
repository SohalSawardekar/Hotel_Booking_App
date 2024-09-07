import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
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
                        'Samarth Kamat', // Placeholder name
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Samarthkamat80@gmail.com', // Placeholder email
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        '+91 7709086986', // Placeholder phone number
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to edit profile page (You can add this feature)
                },
                child: const Text('Edit Profile'),
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
              itemCount: 3, // For demo purposes
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.hotel, color: Colors.grey[700]),
                    title: Text('Hotel Room ${index + 1}'),
                    subtitle: Text('Date: 2024-09-0${index + 1}'),
                    trailing: const Text('Status: Completed'),
                  ),
                );
              },
            ),
            const Divider(),
            // Payment Methods Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Payment Methods',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // Number of saved payment methods
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.payment, color: Colors.grey[700]),
                    title: Text(index == 0
                        ? 'Visa **** 1234'
                        : 'PayPal johndoe@example.com'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Logic to remove payment method
                      },
                    ),
                  ),
                );
              },
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Logic to add new payment method
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Payment Method'),
              ),
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
              leading: Icon(Icons.language, color: Colors.grey[700]),
              title: const Text('Language'),
              onTap: () {
                // Logic for language change
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.grey[700]),
              title: const Text('Notifications'),
              onTap: () {
                // Logic for notifications settings
              },
            ),
            const Divider(),
            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to login page
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 243, 243, 243), // Set a different color for logout
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
