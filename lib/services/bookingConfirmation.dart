import '../constants/ImportFiles.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String paymentId;
  final String roomId;
  final String roomType;
  final String checkInDate;
  final String checkOutDate;
  final double totalAmount;

  BookingConfirmationPage({
    super.key,
    required this.paymentId,
    required this.roomId,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalAmount,
  });

  Future<void> addBookingToFirestore() async {
    try {
      // Get the current user's ID
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the 'bookings' collection
        CollectionReference bookings =
            FirebaseFirestore.instance.collection('bookings');

        // Data to add
        await bookings.add({
          'userId': userId, // Adding the current user's ID
          'roomId': roomId,
          'roomType': roomType,
          'checkInDate': checkInDate,
          'checkOutDate': checkOutDate,
          'totalAmount': totalAmount,
          'status': 'confirmed', // Example field for booking status
          'createdAt':
              FieldValue.serverTimestamp(), // Timestamp of booking creation
        });

        print('Booking added successfully to Firestore with user ID.');
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Failed to add booking: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your booking is confirmed!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Booking Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DetailRow(title: 'Booking ID:', detail: roomId),
            DetailRow(title: 'Room Type:', detail: roomType),
            DetailRow(title: 'Check-In Date:', detail: checkInDate),
            DetailRow(title: 'Check-Out Date:', detail: checkOutDate),
            DetailRow(title: 'Total Amount:', detail: '₹$totalAmount'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Update Firestore with booking details
                  await addBookingToFirestore();

                  // Navigate to Home or any other page
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                child: const Text('Go to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String detail;

  const DetailRow({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            detail,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
