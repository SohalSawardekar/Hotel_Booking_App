import 'package:flutter/material.dart';
import 'package:hotel_booking/screens/payment.dart';
import 'package:intl/intl.dart';

import '../../constants/ImportFiles.dart'; // For formatting dates

class StandardBookingPage extends StatelessWidget {
  const StandardBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double pricePerNight = 3000.0; // Example price
    const double gst = 0.18; // Example GST rate
    final double totalAmount = pricePerNight * (1 + gst);

    // Formatting the check-in and check-out dates for better display
    final checkInDate = DateTime.now();
    final checkOutDate = DateTime.now().add(const Duration(days: 1));
    final String formattedCheckIn =
        DateFormat('dd MMM yyyy').format(checkInDate);
    final String formattedCheckOut =
        DateFormat('dd MMM yyyy').format(checkOutDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard Room Booking'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Title and Image
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/standardroom.jpg'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Room Information Section
              const Text(
                'Standard Room',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Price per Night: ₹${pricePerNight.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),

              // Facilities and Amenities Section with Icons
              const Text(
                'Facilities and Amenities:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.wifi, color: Colors.teal, size: 24),
                  SizedBox(width: 10),
                  Text('Free WiFi', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.ac_unit, color: Colors.teal, size: 24),
                  SizedBox(width: 10),
                  Text('Air Conditioning', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.room_service, color: Colors.teal, size: 24),
                  SizedBox(width: 10),
                  Text('24/7 Room Service', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.local_cafe, color: Colors.teal, size: 24),
                  SizedBox(width: 10),
                  Text('Complimentary Breakfast',
                      style: TextStyle(fontSize: 18)),
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

              // Check-in and Check-out Dates
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
                      'Guests: 1 Adult, 0 Children',
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
                    var roomType = 'standard';
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
