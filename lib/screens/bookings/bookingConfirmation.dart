import 'package:intl/intl.dart';
import '../../constants/ImportFiles.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String paymentId;
  final String roomId;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const BookingConfirmationPage({
    super.key,
    required this.paymentId,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
  });

  @override
  _BookingConfirmationPageState createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  @override
  void initState() {
    super.initState();
    addBookingToFirestore();
  }

  Future<void> addBookingToFirestore() async {
    try {
      // Get the current user's ID
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Reference to the 'Rooms' collection
        CollectionReference rooms =
            FirebaseFirestore.instance.collection('Rooms');

        // Update the selected room's status to 'no' using the roomId
        await rooms.doc(widget.roomId).update({
          'status': 'no',
          'user-id': userId,
          'check-in': widget.checkInDate,
          'check-out': widget.checkOutDate,
        });

        // Reference to the 'Bookings' collection
        CollectionReference bookings =
            FirebaseFirestore.instance.collection('Bookings');

        // Data to add
        await bookings.add({
          'userId': userId, // Adding the current user's ID
          'roomId': widget.roomId,
          'paymentId': widget.paymentId,
          'checkInDate': widget.checkInDate,
          'checkOutDate': widget.checkOutDate,
          'status': 'confirmed', // Example field for booking status
          'createdOn':
              FieldValue.serverTimestamp(), // Timestamp of booking creation
        });

        print('Booking added and room status updated successfully.');
      } else {
        print('No user is currently logged in.');
      }
    } catch (e) {
      print('Failed to add booking and update room status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Format the check-in and check-out dates
    String formattedCheckInDate =
        DateFormat('dd/MM/yyyy').format(widget.checkInDate);
    String formattedCheckOutDate =
        DateFormat('dd/MM/yyyy').format(widget.checkOutDate);

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
            DetailRow(title: 'Room ID:', detail: widget.roomId),
            DetailRow(title: 'Payment ID:', detail: widget.paymentId),
            DetailRow(title: 'Check-In Date:', detail: formattedCheckInDate),
            DetailRow(title: 'Check-Out Date:', detail: formattedCheckOutDate),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Home Screen
                  Navigator.pushReplacementNamed(context, '/home');
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
