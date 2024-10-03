import 'package:intl/intl.dart';

import '../../constants/ImportFiles.dart';

class VillaBookingPage extends StatefulWidget {
  const VillaBookingPage({super.key});

  @override
  _VillaBookingPageState createState() => _VillaBookingPageState();
}

class _VillaBookingPageState extends State<VillaBookingPage> {
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
          .where('room_type', isEqualTo: 'Villa') // Assuming room_type is used
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
    const double gst = 0.18; // GST rate
    final double totalAmount = pricePerNight * (1 + gst);

    final checkInDate = DateTime.now();
    final checkOutDate = DateTime.now().add(const Duration(days: 1));
    final String formattedCheckIn =
        DateFormat('dd MMM yyyy').format(checkInDate);
    final String formattedCheckOut =
        DateFormat('dd MMM yyyy').format(checkOutDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Villa Booking',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: Colors.teal, // Color for a more premium villa look
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Villa Image Section
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/villa.jpg'), // Replace with villa image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Room Title and Price
                    const Text(
                      'Villa',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price per Night: ₹${pricePerNight.toStringAsFixed(2)}',
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),

                    // Facilities and Amenities with Icons
                    const Text(
                      'Facilities and Amenities:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.wifi, color: Colors.teal, size: 28),
                            SizedBox(width: 10),
                            Text('Free WiFi', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.ac_unit, color: Colors.teal, size: 28),
                            SizedBox(width: 10),
                            Text('Air Conditioning',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.pool, color: Colors.teal, size: 28),
                            SizedBox(width: 10),
                            Text('Private Pool',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.spa, color: Colors.teal, size: 28),
                            SizedBox(width: 10),
                            Text('Private Spa', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.restaurant,
                                color: Colors.teal, size: 28),
                            SizedBox(width: 10),
                            Text('In-Villa Dining',
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
                            'Total Amount (with GST):',
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Booking Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check-in Date: $formattedCheckIn',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Check-out Date: $formattedCheckOut',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Guests: 2 Adults, 1 Child',
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
                          var roomType = 'villa';
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
