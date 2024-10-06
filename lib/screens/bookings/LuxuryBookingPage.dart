// ignore_for_file: unused_local_variable

import 'package:intl/intl.dart';
import '../../constants/ImportFiles.dart'; // Adjust import path as needed

class LuxuryBookingPage extends StatefulWidget {
  const LuxuryBookingPage({super.key});

  @override
  _LuxuryBookingPageState createState() => _LuxuryBookingPageState();
}

class _LuxuryBookingPageState extends State<LuxuryBookingPage> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));
  String roomType = 'Luxury';
  int pricePerNight = 10; // Will be fetched from Firestore
  double gst = 0; // Assuming GST is 18%
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoomPrice();
  }

  Future<void> _fetchRoomPrice() async {
    try {
      QuerySnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('room_type', isEqualTo: roomType)
          .get();

      if (roomSnapshot.docs.isNotEmpty) {
        var roomData = roomSnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          pricePerNight = roomData['price'] ?? 0;
          isLoading = false;
        });
      } else {
        setState(() {
          pricePerNight = 0;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching room price: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    final String formattedCheckIn =
        DateFormat('dd MMM yyyy').format(checkInDate);
    final String formattedCheckOut =
        DateFormat('dd MMM yyyy').format(checkOutDate);

    // Total amount calculation with GST
    double totalAmount = pricePerNight * (1 + gst);

    return Scaffold(
      appBar: AppBar(
        title: Text('Luxury Room Booking',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(221, 112, 112, 112),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/luxuryRoom.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Room Title and Price
                    Text(
                      'Luxury Room',
                      style: GoogleFonts.poppins(
                          fontSize: 28, fontWeight: FontWeight.bold),
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
                            Icon(Icons.wifi, color: Colors.black87, size: 24),
                            SizedBox(width: 10),
                            Text('Free WiFi', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.ac_unit,
                                color: Colors.black87, size: 24),
                            SizedBox(width: 10),
                            Text('Air Conditioning',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.bathtub,
                                color: Colors.black87, size: 24),
                            SizedBox(width: 10),
                            Text('Private Jacuzzi',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.room_service,
                                color: Colors.black87, size: 24),
                            SizedBox(width: 10),
                            Text('Butler Service',
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
                        color: isDarkMode
                            ? const Color.fromARGB(230, 199, 199, 199)
                                .withOpacity(0.1)
                            : Colors.black87.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 230, 228, 228)
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            '₹${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 230, 228, 228)
                                  : Colors.black,
                            ),
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
                        border: Border.all(color: Colors.black87, width: 1),
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
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey),
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
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
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
