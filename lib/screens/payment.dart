import 'package:hotel_booking/constants/ImportFiles.dart';
import 'package:hotel_booking/screens/bookings/bookingConfirmation.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  final String roomType;
  final String roomId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;

  const PaymentPage({
    super.key,
    required this.roomType,
    required this.roomId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "sohalsawardekar11@okicici",
      receiverName: 'Sohal Sawardekar',
      transactionRefId: 'TestTransaction',
      transactionNote: 'Hotel Booking Payment',
      amount: widget.totalAmount,
    );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException _:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException _:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException _:
        return 'Requested app didn\'t return any response';
      default:
        return 'An unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction Successful')),
        );
        break;
      case UpiPaymentStatus.SUBMITTED:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction Submitted')),
        );
        break;
      case UpiPaymentStatus.FAILURE:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction Failed')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unknown transaction status')),
        );
    }
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (apps!.isEmpty) {
      return const Center(
        child: Text(
          "No apps found to handle the transaction.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
        ),
        itemCount: apps!.length,
        itemBuilder: (context, index) {
          UpiApp app = apps![index];
          return GestureDetector(
            onTap: () {
              _transaction = initiateTransaction(app);
              setState(() {});
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(
                    app.icon,
                    height: 30,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    app.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget displayTransactionData(String title, String body) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(
        body,
        style: const TextStyle(fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPI Payment',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 38, 38, 38)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    displayTransactionData('Room Type', widget.roomType),
                    displayTransactionData(
                      'Check-in Date',
                      "${widget.checkInDate.day}/${widget.checkInDate.month}/${widget.checkInDate.year}",
                    ),
                    displayTransactionData(
                      'Check-out Date',
                      "${widget.checkOutDate.day}/${widget.checkOutDate.month}/${widget.checkOutDate.year}",
                    ),
                    displayTransactionData('Adults', widget.adults.toString()),
                    displayTransactionData(
                        'Children', widget.children.toString()),
                    displayTransactionData(
                      'Total Amount',
                      '₹${widget.totalAmount.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // Remove Expanded and use Flexible or wrap it in SizedBox with a fixed height
              SizedBox(
                height: 200, // Fix the height or adjust as needed
                child: displayUpiApps(),
              ),
              FutureBuilder<UpiResponse>(
                future: _transaction,
                builder: (BuildContext context,
                    AsyncSnapshot<UpiResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              _upiErrorHandler(snapshot.error.runtimeType),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentPage(
                                      roomType: widget.roomType,
                                      checkInDate: widget.checkInDate,
                                      checkOutDate: widget.checkOutDate,
                                      adults: widget.adults,
                                      children: widget.children,
                                      totalAmount: widget.totalAmount,
                                      roomId: widget.roomId,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Try again"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookingConfirmationPage(
                                      paymentId: 'EU02fP7Roh4He1qn8Wc6',
                                      roomId: widget.roomId,
                                      checkInDate: widget.checkInDate,
                                      checkOutDate: widget.checkOutDate,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Bypass Payment"),
                            ),
                          ],
                        ),
                      );
                    }

                    UpiResponse upiResponse = snapshot.data!;
                    String txnId = upiResponse.transactionId ?? 'N/A';
                    String resCode = upiResponse.responseCode ?? 'N/A';
                    String txnRef = upiResponse.transactionRefId ?? 'N/A';
                    String status = upiResponse.status ?? 'N/A';
                    String approvalRef = upiResponse.approvalRefNo ?? 'N/A';
                    _checkTxnStatus(status);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        displayTransactionData('Response Code', resCode),
                        displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Select Payment Method',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
