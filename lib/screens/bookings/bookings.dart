import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../constants/ImportFiles.dart';

class BookingPage extends StatefulWidget {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String roomType;
  final double totalAmount;

  const BookingPage({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomType,
    required this.totalAmount,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  String roomType = '';
  String location = '';
  int adults = 1;
  int children = 0;
  double roomRate = 0.0;

  final List<String> roomTypes = [
    'standard',
    'premium',
    'luxury',
    'suite',
    'villa',
  ];

  final List<String> locations = [
    'goa',
    'ladakh',
    'kerela',
    'kashmir',
    'jaipur',
    'agra',
    'manali',
  ];

  @override
  void initState() {
    super.initState();
    checkInDate = widget.checkInDate ?? DateTime.now();
    checkOutDate =
        widget.checkOutDate ?? DateTime.now().add(const Duration(days: 1));
    roomType = widget.roomType;

    _fetchRoomRate(roomType);
  }

  void _fetchRoomRate(String roomType) async {
    try {
      // Fetch room rate from Firestore
      final roomSnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('room_type', isEqualTo: roomType)
          .get();

      if (roomSnapshot.docs.isNotEmpty) {
        // Access the first document from the query snapshot
        final roomData = roomSnapshot.docs.first
            .data(); // Get the data from the first document
        setState(() {
          roomRate = roomData['price']?.toDouble() ??
              0.0; // Default value if price is missing
        });
      } else {
        // Handle case where roomType is not found
        setState(() {
          roomRate = 0.0; // Default value when room is not found
        });
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching room rate: $e');
    }
  }

  void _selectDate(bool isCheckIn) async {
    DateTime initialDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'Select a date';
    }
    return DateFormat('dd MMM yyyy').format(date);
  }

  bool _validateInputs() {
    if (checkInDate == null || checkOutDate == null) {
      return false;
    }
    if (checkInDate!.isAfter(checkOutDate!)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Check-in Date'),
              subtitle: Text(formatDate(checkInDate)),
              onTap: () => _selectDate(true),
            ),
            ListTile(
              title: const Text('Check-out Date'),
              subtitle: Text(formatDate(checkOutDate)),
              onTap: () => _selectDate(false),
            ),
            ListTile(
              title: const Text('Room Type'),
              trailing: DropdownButton<String>(
                value: roomTypes.contains(roomType) ? roomType : 'standard',
                items: roomTypes
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    roomType = value!;
                    _fetchRoomRate(roomType);
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Location'),
              trailing: DropdownButton<String>(
                value:
                    locations.contains(location) ? location : locations.first,
                items: locations
                    .map((loc) => DropdownMenuItem<String>(
                          value: loc,
                          child: Text(loc),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    location = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Adults'),
              trailing: DropdownButton<int>(
                value: adults,
                items: List.generate(5, (index) => index + 1)
                    .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text('$e'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    adults = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Children'),
              trailing: DropdownButton<int>(
                value: children,
                items: List.generate(5, (index) => index)
                    .map((e) => DropdownMenuItem<int>(
                          value: e,
                          child: Text('$e'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    children = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Price'),
              trailing: Text(
                '${roomRate}',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvailabilityPage(
                          roomType: roomType,
                          checkInDate: checkInDate!,
                          checkOutDate: checkOutDate!,
                          adults: adults,
                          children: children,
                          totalAmount: roomRate,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Please ensure all fields are filled and dates are valid.'),
                      ),
                    );
                  }
                },
                child: const Text('Check Availability'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
