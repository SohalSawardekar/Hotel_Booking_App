import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;

  const PaymentPage(
      {super.key,
      required this.roomType,
      required this.checkInDate,
      required this.checkOutDate,
      required this.adults,
      required this.children,
      required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Room Type: $roomType'),
            Text('Check-in: ${checkInDate.toLocal()}'.split(' ')[0]),
            Text('Check-out: ${checkOutDate.toLocal()}'.split(' ')[0]),
            Text('Adults: $adults, Children: $children'),
            Text('Total Amount: ₹$totalAmount'),
            const SizedBox(height: 20),
            const Text('Choose Payment Method:'),
            RadioListTile(
              title: const Text('Internet Banking'),
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text('GPay'),
              value: 2,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text('Debit/Credit Card'),
              value: 3,
              groupValue: 1,
              onChanged: (value) {},
            ),
            RadioListTile(
              title: const Text('UPI'),
              value: 4,
              groupValue: 1,
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment logic here
                },
                child: const Text('Proceed to Pay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
