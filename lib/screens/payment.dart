import 'package:hotel_booking/constants/ImportFiles.dart';
import 'package:hotel_booking/screens/feedback.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;
  final String availableRoomId;

  const PaymentPage({
    super.key,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
    required this.availableRoomId,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    // Initialize Razorpay with your test key
    _razorpay = Razorpay();

    // Set event listeners for payment success, failure, and external wallet
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Open Razorpay checkout
    _openCheckout();
  }

  // Function to open the Razorpay checkout
  void _openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf',
      'amount': widget.totalAmount * 100,
      'name': 'Hotel Booking',
      'description': 'Payment for Room Booking',
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FeedbackPage(),
      ),
    );
  }

  // Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");

    // Show error and offer a retry option
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(response.message ?? 'Something went wrong.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openCheckout();
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AvailabilityPage(
                    roomType: widget.roomType,
                    checkInDate: widget.checkInDate,
                    checkOutDate: widget.checkOutDate,
                    adults: widget.adults,
                    children: widget.children,
                    totalAmount: widget.totalAmount,
                  ),
                ),
              );
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Handle external wallet selection
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear all listeners when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
        child: Text('Processing Payment...'), // Simple placeholder UI
      ),
    );
  }
}
