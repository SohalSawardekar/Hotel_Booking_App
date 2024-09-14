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
  String roomType = 'standard';
  String location = 'goa';
  int adults = 1;
  int children = 0;
  double roomRate = 5000;

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
    // Initialize with values passed from LuxuryBookingPage or use default dates
    checkInDate = widget.checkInDate ?? DateTime.now();
    checkOutDate =
        widget.checkOutDate ?? DateTime.now().add(const Duration(days: 1));
    roomType = widget.roomType;
    // Set roomRate based on roomType if needed
    // Example: roomRate = getRoomRate(roomType);
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
                value:
                    roomTypes.contains(roomType) ? roomType : roomTypes.first,
                items: roomTypes
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    roomType = value!;
                    // Optional: Update roomRate based on selected roomType
                    // Example: roomRate = getRoomRate(value);
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
                    // Show error message
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
