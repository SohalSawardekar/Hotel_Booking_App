// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

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
  // ignore: non_constant_identifier_names
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Rating
                  const Text(
                    'Rate Your Experience:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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
                  const SizedBox(height: 20),

                  // Cleanliness
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

                  // Staff
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

                  // Value for Money
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

                  // Comments
                  TextFormField(
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
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitFeedback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Submit Feedback',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
}
