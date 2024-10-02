// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  final String paymentMethod;
  final String roomType;
  final double? totalAmount; // Making totalAmount nullable
  final DateTime? checkInDate; // Nullable check-in date
  final DateTime? checkOutDate; // Nullable check-out date
  final int? adults; // Nullable adults count
  final int? children; // Nullable children count

  const FeedbackPage({
    Key? key,
    required this.paymentMethod,
    required this.roomType,
    this.totalAmount,
    this.checkInDate,
    this.checkOutDate,
    this.adults,
    this.children,
  }) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;
  String _comments = '';
  String _cleanliness = '';
  String _staff = '';
  String _valueForMoney = '';

  bool _isSubmitting = false;

  void _submitFeedback() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate a network request
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSubmitting = false;
        });

        // Show thank you message and navigate to Home Page
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thank You!'),
            content: const Text(
                'Thank you for your feedback. We appreciate your input!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We value your feedback!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            _buildRoomDetails(),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildRatingSection(),
                  const SizedBox(height: 20),
                  _buildTextField(
                    'How would you rate the cleanliness?',
                    (value) {
                      _cleanliness = value ?? '';
                      return value != null && value.isNotEmpty
                          ? null
                          : 'Please provide a rating.';
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    'How would you rate the staff?',
                    (value) {
                      _staff = value ?? '';
                      return value != null && value.isNotEmpty
                          ? null
                          : 'Please provide a rating.';
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    'How would you rate the value for money?',
                    (value) {
                      _valueForMoney = value ?? '';
                      return value != null && value.isNotEmpty
                          ? null
                          : 'Please provide a rating.';
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildCommentsSection(),
                  const SizedBox(height: 20),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Room Type: ${widget.roomType}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        if (widget.totalAmount != null)
          Text(
            'Total Amount: ₹${widget.totalAmount!.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        if (widget.checkInDate != null)
          Text(
            'Check-in: ${widget.checkInDate}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        if (widget.checkOutDate != null)
          Text(
            'Check-out: ${widget.checkOutDate}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        if (widget.adults != null)
          Text(
            'Adults: ${widget.adults}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        if (widget.children != null)
          Text(
            'Children: ${widget.children}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate Your Experience:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 40,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.deepPurple,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Additional Comments',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
      onChanged: (value) {
        setState(() {
          _comments = value;
        });
      },
      validator: (value) {
        return value != null && value.isNotEmpty
            ? null
            : 'Please provide your comments.';
      },
    );
  }

  Widget _buildTextField(String label, FormFieldValidator<String>? validator) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitFeedback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: _isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Submit Feedback',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
