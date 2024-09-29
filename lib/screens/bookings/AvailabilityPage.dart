import 'dart:math';
import 'package:intl/intl.dart';
import 'package:hotel_booking/constants/ImportFiles.dart'; // Adjust import path as needed

class AvailabilityPage extends StatefulWidget {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;

  const AvailabilityPage({
    super.key,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
  });

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  bool _isCheckingAvailability = false;
  bool _isAvailable = false;
  String _availabilityMessage = '';
  String _roomID = '';

  @override
  void initState() {
    super.initState();
    _checkRoomAvailability();
  }

  Future<void> _checkRoomAvailability() async {
    setState(() {
      _isCheckingAvailability = true;
    });

    try {
      // Firestore query to fetch rooms that match the roomType and have status 'yes'
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('roomType', isEqualTo: widget.roomType)
          .where('status', isEqualTo: 'yes')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Select a random room from the available ones
        var randomRoom =
            querySnapshot.docs[Random().nextInt(querySnapshot.docs.length)];

        setState(() {
          _isCheckingAvailability = false;
          _isAvailable = true;
          _availabilityMessage =
              'Room is available: ${randomRoom['roomName']}'; // Update with room name or other details
          _roomID = randomRoom.id; // Store the room ID for future use
        });
      } else {
        setState(() {
          _isCheckingAvailability = false;
          _isAvailable = false;
          _availabilityMessage = 'No rooms available for the selected type.';
        });
      }
    } catch (e) {
      setState(() {
        _isCheckingAvailability = false;
        _isAvailable = false;
        _availabilityMessage = 'Error checking availability: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Availability'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room details card with modern design
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                shadowColor: Colors.grey.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 25.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.roomType,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow(
                        'Check-in',
                        DateFormat('MMM dd, yyyy').format(widget.checkInDate),
                        Icons.date_range,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Check-out',
                        DateFormat('MMM dd, yyyy').format(widget.checkOutDate),
                        Icons.date_range,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Adults',
                        widget.adults.toString(),
                        Icons.person_outline,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Children',
                        widget.children.toString(),
                        Icons.child_care,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Availability check section
              Center(
                child: _isCheckingAvailability
                    ? const Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text(
                            'Checking availability...',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                        ],
                      )
                    : _buildAvailabilityMessage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo, size: 20),
        const SizedBox(width: 8),
        Text(
          '$title: $value',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityMessage() {
    return Column(
      children: [
        Text(
          _availabilityMessage,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _isAvailable ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 30),
        if (_isAvailable)
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    roomType: widget.roomType,
                    checkInDate: widget.checkInDate,
                    checkOutDate: widget.checkOutDate,
                    adults: widget.adults,
                    children: widget.children,
                    totalAmount: widget.totalAmount,
                    roomID: _roomID,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigoAccent,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.25,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Confirm Availability and Proceed',
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],
    );
  }
}
