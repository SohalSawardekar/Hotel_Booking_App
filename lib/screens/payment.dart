import 'package:flutter/material.dart';
import 'package:hotel_booking/screens/feedback.dart';
import 'package:intl/intl.dart'; // For currency formatting

class PaymentPage extends StatefulWidget {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;
  final String roomID;

  const PaymentPage({
    super.key,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
    required this.roomID,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? _selectedPaymentMethod;
  String? _selectedBank;
  String? _cardNumber;
  final List<String> _internetBankingOptions = [
    'HDFC Bank',
    'SBI',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank'
  ];
  final List<String> _upiOptions = [
    'PhonePe',
    'Google Pay',
    'Paytm',
    'Amazon Pay',
    'BharatPe'
  ];

  @override
  Widget build(BuildContext context) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 8,
              shadowColor: Colors.grey.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Summary',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                    ),
                    const SizedBox(height: 10),
                    _buildSummaryRow('Room Type', widget.roomType),
                    _buildSummaryRow('Check-in',
                        DateFormat('MMM dd, yyyy').format(widget.checkInDate)),
                    _buildSummaryRow('Check-out',
                        DateFormat('MMM dd, yyyy').format(widget.checkOutDate)),
                    _buildSummaryRow('Adults', widget.adults.toString()),
                    _buildSummaryRow('Children', widget.children.toString()),
                    _buildSummaryRow('Total Amount',
                        currencyFormatter.format(widget.totalAmount)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Choose Payment Method
            Text(
              'Choose Payment Method:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 10),
            _buildPaymentMethodOption('Internet Banking', Icons.web, 1),
            _buildPaymentMethodOption('Google Pay', Icons.payments, 2),
            _buildPaymentMethodOption(
                'Debit/Credit Card', Icons.credit_card, 3),
            _buildPaymentMethodOption('UPI', Icons.account_balance, 4),
            const SizedBox(height: 20),

            // Proceed to Pay Button
            Center(
              child: ElevatedButton(
                onPressed: _handlePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Proceed to Pay',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayment() {
    // Implement payment handling based on selected payment method
    if (_selectedPaymentMethod == 1) {
      // Handle Internet Banking
      _showBankSelectionDialog();
    } else if (_selectedPaymentMethod == 2) {
      // Handle Google Pay
      _proceedToNextPage('Google Pay');
    } else if (_selectedPaymentMethod == 3) {
      // Handle Debit/Credit Card
      _showCardNumberInputDialog();
    } else if (_selectedPaymentMethod == 4) {
      // Handle UPI
      _showUpiSelectionDialog();
    } else {
      _showPaymentCompletedDialog();
    }
  }

  void _showBankSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Bank for Internet Banking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _internetBankingOptions.map((bank) {
            return ListTile(
              title: Text(bank),
              onTap: () {
                Navigator.of(context).pop();
                _proceedToNextPage('Internet Banking with $bank');
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showUpiSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select UPI App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _upiOptions.map((upi) {
            return ListTile(
              title: Text(upi),
              onTap: () {
                Navigator.of(context).pop();
                _proceedToNextPage('UPI with $upi');
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCardNumberInputDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Card Number'),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter 12 or 16-digit card number',
          ),
          onChanged: (value) {
            _cardNumber = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _proceedToNextPage(
                  'Debit/Credit Card ending with ${_cardNumber?.substring(_cardNumber!.length - 4)}');
            },
            child: const Text('Proceed'),
          ),
        ],
      ),
    );
  }

  void _proceedToNextPage(String method) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => PaymentCompletedPage(method: method),
      ),
    );
  }

  void _showPaymentCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Completed'),
        content: const Text('Your payment has been successfully processed.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => FeedbackPage(),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(
      String methodName, IconData icon, int value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: Colors.deepPurple,
      ),
      title: Text(
        methodName,
        style: const TextStyle(fontSize: 16),
      ),
      contentPadding: EdgeInsets.zero,
      tileColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
    );
  }
}

class PaymentCompletedPage extends StatelessWidget {
  final String method;

  const PaymentCompletedPage({super.key, required this.method});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Completed'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Payment Completed using $method',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
        ),
      ),
    );
  }
}
