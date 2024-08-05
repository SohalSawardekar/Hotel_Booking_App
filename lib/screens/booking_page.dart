import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "package:provider/provider.dart";
import "../main.dart";
import 'dart:ui';

class Booking {
  final String roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  Booking({
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
  });
}

class BookingPage extends StatelessWidget {
  final TextEditingController roomTypeController = TextEditingController();
  final TextEditingController checkInDateController = TextEditingController();
  final TextEditingController checkOutDateController = TextEditingController();
  final String room = '';
  final String startDate = '';
  final String endDate = '';

  BookingPage({super.key});

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, String date) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }

    date = controller.text;
  }

  Future<void> _SelectRoomType(
      BuildContext context, TextEditingController controller) async {
    // List of room types
    final List<String> roomTypes = ['Single', 'Double', 'Suite'];

    // Show a dialog to select room type
    final String? selectedRoomType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Room Type'),
          children: roomTypes.map((String roomType) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, roomType);
              },
              child: Text(roomType),
            );
          }).toList(),
        );
      },
    );

    // If a room type was selected, update the controller text
    if (selectedRoomType != null) {
      controller.text = selectedRoomType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Book a Room'),
        backgroundColor: Colors.amber[800],
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.amber[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  controller: roomTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Room Type',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => {
                        _SelectRoomType(context, roomTypeController),
                      }),
              const SizedBox(height: 10),
              TextField(
                  controller: checkInDateController,
                  decoration: const InputDecoration(
                    labelText: 'Check-in Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => {
                        _selectDate(context, checkInDateController, startDate),
                      }),
              const SizedBox(height: 10),
              TextField(
                  controller: checkOutDateController,
                  decoration: const InputDecoration(
                    labelText: 'Check-out Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () => {
                        _selectDate(context, checkOutDateController, endDate),
                      }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final booking = Booking(
                    roomType: roomTypeController.text,
                    checkInDate: DateTime.parse(checkInDateController.text),
                    checkOutDate: DateTime.parse(checkOutDateController.text),
                  );
                  Provider.of<BookingProvider>(context, listen: false)
                      .addBooking(booking);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 246, 159, 46),
                ),
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
