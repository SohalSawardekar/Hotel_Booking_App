import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class feedbackPage extends StatefulWidget {
  const feedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<feedbackPage> {
  int _rating = 0;
  TextEditingController _commentsController = TextEditingController();

  void _submitFeedback() {
    // Handle feedback submission
    String comments = _commentsController.text;
    // You can send this data to your server or database
    print('Rating: $_rating');
    print('Comments: $comments');

    // Clear the form
    setState(() {
      _rating = 0;
      _commentsController.clear();
    });

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thank you for your feedback!')),
    );
  }

  Widget _buildStar(int starIndex) {
    return IconButton(
      icon: Icon(
        starIndex <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
      ),
      onPressed: () {
        setState(() {
          _rating = starIndex;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Feedback',
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color.fromARGB(255, 142, 193, 235),
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
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 23, 60, 91)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Rate your stay:',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) => _buildStar(index + 1)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _commentsController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Comments',
                      labelStyle: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ));
  }
}
