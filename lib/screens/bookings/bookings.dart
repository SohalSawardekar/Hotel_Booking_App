import 'package:intl/intl.dart';
import '../../constants/ImportFiles.dart';

class BookingPage extends StatefulWidget {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String roomType;
  final double? totalAmount;

  const BookingPage({
    super.key,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomType,
    this.totalAmount,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int adults = 1;
  int children = 0;
  double roomRate = 1500.00; // Default room rate
  int price = 0;
  String selectedRoomType = "Standard";
  String selectedlocation = "goa";
  bool isLoading = false;

  final List<String> roomTypes = [
    "Standard",
    "Premium",
    "Luxury",
    "Suite",
    "Villa",
  ];

  final List<String> location = [
    "agra",
    "goa",
    "jaipur",
    "kashmir",
    "kerela",
    "ladakh",
    "manali",
  ];

  Future<void> _fetchRoomPrice() async {
    setState(() {
      isLoading = true;
    });

    try {
      QuerySnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('room_type', isEqualTo: selectedRoomType)
          .where('location', isEqualTo: selectedlocation)
          .get();

      if (roomSnapshot.docs.isNotEmpty) {
        var roomData = roomSnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          price = roomData['price'] ?? 0;
          roomRate = price.toDouble();
          isLoading = false;
        });
      } else {
        setState(() {
          price = 0;
          roomRate = price.toDouble();
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

  double _calculateTotalPrice() {
    if (checkInDate != null && checkOutDate != null) {
      int numberOfNights = checkOutDate!.difference(checkInDate!).inDays;
      return numberOfNights * roomRate + (adults - 1) * 500 + children * 300;
    }
    return 0.0;
  }

  @override
  void initState() {
    super.initState();

    // Check if checkInDate and checkOutDate are passed; if not, set defaults
    checkInDate = widget.checkInDate ?? DateTime.now();
    checkOutDate =
        widget.checkOutDate ?? DateTime.now().add(const Duration(days: 1));

    // Check if roomType is passed; if not, set to "Standard"
    selectedRoomType = widget.roomType.isNotEmpty
        ? widget.roomType.toString()
        : selectedRoomType;

    // If totalAmount is passed, use it; otherwise fetch room price
    if (widget.totalAmount != null) {
      _fetchRoomPrice();
    } else {
      roomRate = widget.totalAmount!;
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
    setState(() {
      if (isCheckIn) {
        checkInDate = picked;
      } else {
        checkOutDate = picked;
      }
    });
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
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;

    int numberOfNights = checkInDate != null && checkOutDate != null
        ? checkOutDate!.difference(checkInDate!).inDays
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Your Stay',
          style: GoogleFonts.poppins(
              color: const Color.fromRGBO(255, 255, 255, 1),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Plan Your Perfect Stay',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? const Color.fromARGB(255, 255, 255, 255)
                      : Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 30),
              _buildDateSelector(
                context,
                'Check-in Date',
                formatDate(checkInDate),
                () async {
                  DateTime initialDate = checkInDate ??
                      DateTime.now(); // Use selected check-in or today's date
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate:
                        initialDate, // Start the picker at the selected check-in date
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      checkInDate = picked;
                      // Adjust check-out if needed
                      if (checkOutDate != null &&
                          checkOutDate!.isBefore(checkInDate!)) {
                        checkOutDate =
                            checkInDate!.add(const Duration(days: 1));
                      }
                    });
                  }
                },
                isDarkMode,
              ),
              const SizedBox(height: 20),
              _buildDateSelector(
                context,
                'Check-out Date',
                formatDate(checkOutDate),
                () async {
                  DateTime initialDate = checkInDate ??
                      DateTime.now(); // Ensure it's after check-in
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate.add(const Duration(
                        days: 1)), // Ensure at least 1 day after check-in
                    firstDate: initialDate.add(const Duration(
                        days: 1)), // The minimum date is 1 day after check-in
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      checkOutDate = picked;
                    });
                  }
                },
                isDarkMode,
              ),
              const SizedBox(height: 20),
              _buildRoomTypeDropdown(textColor, backgroundColor),
              const SizedBox(height: 20),
              _buildlocationDropdown(textColor, backgroundColor),
              const SizedBox(height: 20),
              _buildAdultChildrenSelector(
                  textColor,
                  'Adults',
                  adults,
                  () => setState(() => adults++),
                  () => setState(() => adults > 1 ? adults-- : null)),
              const SizedBox(height: 20),
              _buildAdultChildrenSelector(
                  textColor,
                  'Children',
                  children,
                  () => setState(() => children++),
                  () => setState(() => children > 0 ? children-- : null)),
              const SizedBox(height: 40),
              isLoading
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room Rate: ₹${roomRate.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 15,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Time: $numberOfNights days',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Total Price: ₹${_calculateTotalPrice().toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvailabilityPage(
                            roomType: selectedRoomType,
                            checkInDate: checkInDate!,
                            checkOutDate: checkOutDate!,
                            adults: adults,
                            children: children,
                            totalAmount: _calculateTotalPrice(),
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
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 40.0),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Check Availability',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, String label, String dateText,
      VoidCallback onTap, bool isDarkMode) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              dateText,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomTypeDropdown(Color textColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and dropdown
        children: [
          Expanded(
            // Text on the left
            child: Text(
              "Room Type",
              style: GoogleFonts.poppins(
                  color: textColor, fontWeight: FontWeight.w600),
            ),
          ),
          DropdownButton<String>(
            value: selectedRoomType,
            onChanged: (String? newValue) {
              setState(() {
                selectedRoomType = newValue!;
                _fetchRoomPrice();
              });
            },
            underline: const SizedBox.shrink(),
            items: roomTypes.map<DropdownMenuItem<String>>((String roomType) {
              return DropdownMenuItem<String>(
                value: roomType,
                child: Text(
                  roomType,
                  style: GoogleFonts.poppins(
                      color: textColor, fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildlocationDropdown(Color textColor, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and dropdown
        children: [
          Expanded(
            // Text on the left
            child: Text(
              "Destination",
              style: GoogleFonts.poppins(
                  color: textColor, fontWeight: FontWeight.w600),
            ),
          ),
          DropdownButton<String>(
            value: selectedlocation,
            onChanged: (String? newValue) {
              setState(() {
                selectedlocation = newValue!;
                _fetchRoomPrice();
              });
            },
            underline: const SizedBox.shrink(),
            items: location.map<DropdownMenuItem<String>>((String location) {
              return DropdownMenuItem<String>(
                value: location,
                child: Text(
                  location,
                  style: GoogleFonts.poppins(
                      color: textColor, fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAdultChildrenSelector(Color textColor, String label, int value,
      VoidCallback onAdd, VoidCallback onRemove) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 18, color: textColor),
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }
}
