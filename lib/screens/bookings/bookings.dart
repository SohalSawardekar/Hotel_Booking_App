import 'package:hotel_booking/constants/ImportFiles.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

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

  void _selectDate(bool isCheckIn) async {
    DateTime initialDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
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
              subtitle: Text(checkInDate != null
                  ? '${checkInDate!.toLocal()}'.split(' ')[0]
                  : 'Select a date'),
              onTap: () => _selectDate(true),
            ),
            ListTile(
              title: const Text('Check-out Date'),
              subtitle: Text(checkOutDate != null
                  ? '${checkOutDate!.toLocal()}'.split(' ')[0]
                  : 'Select a date'),
              onTap: () => _selectDate(false),
            ),
            ListTile(
              title: const Text('Room Type'),
              trailing: DropdownButton<String>(
                value: roomType,
                items: [
                  'standard',
                  'premium',
                  'luxury',
                  'suite',
                  'villa',
                ]
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                              type), // Display the item in lowercase as it is
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    roomType =
                        value!; // Ensure the value is properly set in lowercase
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Location'),
              trailing: DropdownButton<String>(
                value: location,
                items: [
                  'goa',
                  'ladakh',
                  'kerela',
                  'kashmir',
                  'jaipur',
                  'agra',
                  'manali'
                ]
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        switch (roomType) {
                          case 'Standard':
                            return const StandardBookingPage();
                          case 'Premium':
                            return const PremiumBookingPage();
                          case 'Luxury':
                            return const LuxuryBookingPage();
                          case 'Suite':
                            return const SuiteBookingPage();
                          default:
                            return const StandardBookingPage();
                        }
                      },
                    ),
                  );
                },
                child: const Text('Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
