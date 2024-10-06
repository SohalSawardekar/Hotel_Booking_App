// ignore_for_file: avoid_print, unused_local_variable

import 'package:intl/intl.dart';
import '../../constants/ImportFiles.dart'; // Ensure this import is correct for BookingPage

class StandardBookingPage extends StatefulWidget {
  const StandardBookingPage({super.key});

  @override
  _StandardBookingPageState createState() => _StandardBookingPageState();
}

class _StandardBookingPageState extends State<StandardBookingPage> {
  int pricePerNight = 0; // Will be fetched from Firestore
  bool isLoading = true; // Loading state for fetching price

  @override
  void initState() {
    super.initState();
    _fetchRoomPrice(); // Fetch room price when the page initializes
  }

  Future<void> _fetchRoomPrice() async {
    try {
      QuerySnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('Rooms') // Adjust the collection name as needed
          .where('room_type',
              isEqualTo: 'Standard') // Assuming room_type is used
          .get();

      if (roomSnapshot.docs.isNotEmpty) {
        var roomData = roomSnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          pricePerNight = roomData['price'] ?? 0; // Fetch price or default to 0
          isLoading = false; // Stop loading after fetching the price
        });
      } else {
        setState(() {
          pricePerNight = 0; // No room found
          isLoading = false; // Stop loading
        });
      }
    } catch (e) {
      print('Error fetching room price: $e');
      setState(() {
        isLoading = false; // Stop loading even in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate GST and total amount
    const double gst = 0; // GST rate
    final double totalAmount = pricePerNight * (1 + gst);

    final checkInDate = DateTime.now();
    final checkOutDate = DateTime.now().add(const Duration(days: 1));
    final String formattedCheckIn =
        DateFormat('dd MMM yyyy').format(checkInDate);
    final String formattedCheckOut =
        DateFormat('dd MMM yyyy').format(checkOutDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Standard Room Booking',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Standard Room Image Section
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/standardroom.jpg'), // Add your standard room image here
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Room Title and Price
                    const Text(
                      'Standard Room',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price per Night: ₹${pricePerNight.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),

                    // Facilities and Amenities with Icons
                    const Text(
                      'Facilities and Amenities:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi, color: Colors.teal, size: 24),
                            SizedBox(width: 10),
                            Text('Free WiFi', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.ac_unit, color: Colors.teal, size: 24),
                            SizedBox(width: 10),
                            Text('Air Conditioning',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.local_bar, color: Colors.teal, size: 24),
                            SizedBox(width: 10),
                            Text('Mini Bar', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.lock, color: Colors.teal, size: 24),
                            SizedBox(width: 10),
                            Text('In-Room Safe',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Total Amount Section
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹${totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Booking Details Section
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.teal, width: 1),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Booking Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Check-in Date: xx-xx-xxxx',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Check-out Date: xx-xx-xxxx',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Guests: x Adult, x Children',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Proceed to Payment Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          var roomType = 'Standard';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(
                                checkInDate: checkInDate,
                                checkOutDate: checkOutDate,
                                roomType: roomType,
                                totalAmount: totalAmount,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Proceed',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
