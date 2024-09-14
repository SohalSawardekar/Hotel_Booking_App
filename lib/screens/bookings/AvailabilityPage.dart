import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:hotel_booking/constants/ImportFiles.dart'; // Adjust import path as needed

class AvailabilityPage extends StatefulWidget {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final double totalAmount;

  const AvailabilityPage({
    super.key,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.totalAmount,
  });

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  bool _isCheckingAvailability = false;
  bool _isAvailable = false;
  String _availabilityMessage = '';

  @override
  void initState() {
    super.initState();
    _checkRoomAvailability();
  }

  Future<void> _checkRoomAvailability() async {
    setState(() {
      _isCheckingAvailability = true;
    });

    try {
      // Fetch room number from 'rooms' collection
      final roomQuerySnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .where('room_type', isEqualTo: widget.roomType)
          .get();

      if (roomQuerySnapshot.docs.isNotEmpty) {
        final roomDoc = roomQuerySnapshot.docs.first;
        final roomNumber =
            roomDoc['room_no']; // Fetch the room number from the document

        // Check availability from 'available_rooms' collection
        final availableRoomSnapshot = await FirebaseFirestore.instance
            .collection('available_rooms')
            .where('room_no', isEqualTo: roomNumber)
            .get();

        if (availableRoomSnapshot.docs.isNotEmpty) {
          setState(() {
            _isAvailable = true;
            _availabilityMessage = 'The room is available.';
          });
        } else {
          setState(() {
            _isAvailable = false;
            _availabilityMessage = 'The room is not available.';
          });
        }
      } else {
        setState(() {
          _isAvailable = false;
          _availabilityMessage =
              'No information available for the selected room type.';
        });
      }
    } catch (e) {
      setState(() {
        _isAvailable = false;
        _availabilityMessage =
            'Error checking availability. Please try again later.';
      });
    } finally {
      setState(() {
        _isCheckingAvailability = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Room Type: ${widget.roomType}'),
            Text(
                'Check-in: ${DateFormat('yyyy-MM-dd').format(widget.checkInDate)}'),
            Text(
                'Check-out: ${DateFormat('yyyy-MM-dd').format(widget.checkOutDate)}'),
            Text('Adults: ${widget.adults}, Children: ${widget.children}'),
            Text('Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            if (_isCheckingAvailability) ...[
              const Text('Checking availability...'),
            ] else ...[
              Text(_availabilityMessage),
              if (_isAvailable) ...[
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
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
                    child: const Text('Confirm Availability and Proceed'),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
