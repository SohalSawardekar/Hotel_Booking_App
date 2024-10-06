import 'package:flutter/foundation.dart';
import 'package:hotel_booking/constants/ImportFiles.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  User? currentUser;
  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;
  List<Map<String, dynamic>> bookingDetails = [];

  @override
  void initState() {
    super.initState();
    fetchUserBookingDetails();
  }

  Future<List<String>> fetchUserBookingIds() async {
    List<String> bookingIds = [];

    try {
      currentUser = _auth.currentUser;
      if (currentUser != null) {
        uid = currentUser!.uid;
      }

      final querySnapshot = await _firestore
          .collection('Bookings')
          .where('userId', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          bookingIds.add(doc.id);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user booking IDs: $e");
      }
    }

    return bookingIds;
  }

  Future<void> fetchUserBookingDetails() async {
    try {
      List<String> bookingIds = await fetchUserBookingIds();
      if (bookingIds.isNotEmpty) {
        for (String id in bookingIds) {
          var bookingDoc =
              await _firestore.collection('Bookings').doc(id).get();
          if (bookingDoc.exists) {
            var bookingData = bookingDoc.data() as Map<String, dynamic>;
            String roomId = bookingData['roomId'];
            var roomDoc =
                await _firestore.collection('Rooms').doc(roomId).get();
            bookingDetails.add(roomDoc.data() as Map<String, dynamic>);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching booking details: $e");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(title: const Text("Booking History")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookingDetails.isEmpty
              ? Center(
                  child: Text(
                  "No booking history found.",
                  style: GoogleFonts.poppins(
                      color: isDarkMode ? Colors.white : Colors.black),
                ))
              : ListView.builder(
                  itemCount: bookingDetails.length,
                  itemBuilder: (context, index) {
                    final booking = bookingDetails[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          elevation:
                              WidgetStateProperty.all(0), // Remove shadow
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(18),
                            tileColor: const Color.fromARGB(255, 181, 250, 189),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 181, 250, 189),
                                width: 1,
                              ),
                            ),
                            title: Text(
                              'Room Type: ${booking['room_type']}',
                              style: GoogleFonts.poppins(
                                  color: isDarkMode
                                      ? Colors.green[900]
                                      : Colors.green[600],
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price: ${booking['price']}',
                                  style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.green[900]
                                          : Colors.green[600],
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Location: ${booking['location']}',
                                  style: GoogleFonts.poppins(
                                      color: isDarkMode
                                          ? Colors.green[900]
                                          : Colors.green[600],
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            trailing: Text(
                              'Room: ${booking['room_no']}',
                              style: GoogleFonts.poppins(
                                  color: isDarkMode
                                      ? Colors.green[900]
                                      : Colors.green[600],
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
