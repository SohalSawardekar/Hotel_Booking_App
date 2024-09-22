import 'package:flutter/material.dart';
import 'package:hotel_booking/screens/bookings/bookings.dart';
import 'package:intl/intl.dart';

// For formatting dates

class VillaBookingPage extends StatelessWidget {
  const VillaBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double pricePerNight = 15000.0; // Example price for villa
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
        title: const Text('Villa Booking'),
        backgroundColor: Colors.teal, // Color for a more premium villa look
      ),
      body: SingleChildScrollView(
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Price per Night: ₹${pricePerNight.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Facilities and Amenities with Icons
              const Text(
                'Facilities and Amenities:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      Text('Air Conditioning', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.pool, color: Colors.teal, size: 28),
                      SizedBox(width: 10),
                      Text('Private Pool', style: TextStyle(fontSize: 18)),
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
                      Icon(Icons.restaurant, color: Colors.teal, size: 28),
                      SizedBox(width: 10),
                      Text('In-Villa Dining', style: TextStyle(fontSize: 18)),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Check-in Date: $formattedCheckIn',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Check-out Date: $formattedCheckOut',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
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
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
