import 'package:hotel_booking/screens/feedback.dart';
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
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        CollectionReference rooms =
            FirebaseFirestore.instance.collection('Rooms');

        await rooms.doc(widget.roomId).update({
          'status': 'no',
          'user-id': userId,
          'check-in': widget.checkInDate,
          'check-out': widget.checkOutDate,
        });

        CollectionReference bookings =
            FirebaseFirestore.instance.collection('Bookings');

        await bookings.add({
          'userId': userId,
          'roomId': widget.roomId,
          'paymentId': widget.paymentId,
          'checkInDate': widget.checkInDate,
          'checkOutDate': widget.checkOutDate,
          'status': 'confirmed',
          'createdOn': FieldValue.serverTimestamp(),
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
    String formattedCheckInDate =
        DateFormat('dd/MM/yyyy').format(widget.checkInDate);
    String formattedCheckOutDate =
        DateFormat('dd/MM/yyyy').format(widget.checkOutDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Your Booking is Confirmed!',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DetailRow(title: 'Room ID:', detail: widget.roomId),
                      DetailRow(title: 'Payment ID:', detail: widget.paymentId),
                      DetailRow(
                          title: 'Check-In Date:',
                          detail: formattedCheckInDate),
                      DetailRow(
                          title: 'Check-Out Date:',
                          detail: formattedCheckOutDate),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Bookinghistory()));
                  },
                  child: const Text('Go to Booking History'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FeedbackPage()));
                  },
                  child: const Text('Go to Home'),
                ),
              ),
            ],
          ),
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
