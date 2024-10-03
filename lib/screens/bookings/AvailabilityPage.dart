import 'package:hotel_booking/constants/ImportFiles.dart';
import 'package:intl/intl.dart';

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
  String _availableRoomId = ''; // Variable to store the room ID

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
      // Query Firestore for the room status based on the room type
      QuerySnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('room_type', isEqualTo: widget.roomType)
          .where('status',
              isEqualTo: 'yes') // Check only rooms with status 'yes'
          .limit(1) // Fetch only one room
          .get();

      if (roomSnapshot.docs.isNotEmpty) {
        var roomData = roomSnapshot.docs.first.data() as Map<String, dynamic>;
        String roomId = roomSnapshot.docs.first.id; // Get the room ID

        // Store the available room ID
        setState(() {
          _availableRoomId = roomId;
          _isAvailable = true;
          _availabilityMessage = 'The room is available.';
        });
      } else {
        setState(() {
          _isAvailable = false;
          _availabilityMessage = 'No available rooms found.';
        });
      }
    } catch (error) {
      setState(() {
        _isAvailable = false;
        _availabilityMessage = 'Error checking availability: $error';
      });
    }

    setState(() {
      _isCheckingAvailability = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Availability',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: isDarkMode ? Colors.black87 : Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 12,
                shadowColor: Colors.grey.withOpacity(0.5),
                color: isDarkMode ? Colors.black87 : Colors.white,
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
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.yellow : Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow(
                        'Check-in',
                        DateFormat('MMM dd, yyyy').format(widget.checkInDate),
                        Icons.date_range,
                        isDarkMode,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Check-out',
                        DateFormat('MMM dd, yyyy').format(widget.checkOutDate),
                        Icons.date_range,
                        isDarkMode,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Adults',
                        widget.adults.toString(),
                        Icons.person_outline,
                        isDarkMode,
                      ),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                        'Children',
                        widget.children.toString(),
                        Icons.child_care,
                        isDarkMode,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.yellow : Colors.black87,
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
                    ? Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 20),
                          Text(
                            'Checking availability...',
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 255, 239, 92)
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      )
                    : _buildAvailabilityMessage(isDarkMode),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String title, String value, IconData icon, bool isDarkMode) {
    return Row(
      children: [
        Icon(icon, color: isDarkMode ? Colors.yellow : Colors.indigo, size: 24),
        const SizedBox(width: 8),
        Text(
          '$title: $value',
          style: TextStyle(
            fontSize: 18,
            color: isDarkMode
                ? const Color.fromARGB(255, 255, 239, 92)
                : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityMessage(bool isDarkMode) {
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
                      // roomId: _availableRoomId,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDarkMode ? Colors.yellow : Colors.indigoAccent,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.10,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'Confirm and Proceed',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: isDarkMode ? Colors.black : Colors.white,
                  ),
                ),
              )),
      ],
    );
  }
}
