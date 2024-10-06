// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/ImportFiles.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  double _overallRating = 0;
  // ignore: unused_field
  String _comments = '';
  int? _cleanliness;
  int? _staff;
  int? _valueForMoney;

  bool _isSubmitting = false;

  final List<int> _pointOptions = [1, 2, 3, 4, 5];

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
        title: Text(
          'Feedback',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildRatingSection(),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    'How would you rate our online booking?',
                    (value) {
                      setState(() {
                        _cleanliness = value as int?;
                      });
                      return _cleanliness != null
                          ? null
                          : 'Please select a rating.';
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    'How would you rate our online service?',
                    (value) {
                      setState(() {
                        _staff = value as int?;
                      });
                      return _staff != null ? null : 'Please select a rating.';
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDropdownField(
                    'How would you rate the value for money?',
                    (value) {
                      setState(() {
                        _valueForMoney = value as int?;
                      });
                      return _valueForMoney != null
                          ? null
                          : 'Please select a rating.';
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

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overall Experience (1-5):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        RatingBar.builder(
          initialRating: _overallRating,
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
              _overallRating = rating;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(
      String label, FormFieldValidator<dynamic>? validator) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(
          width: 100, // Control the width of the dropdown
          child: DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: _pointOptions
                .map(
                  (value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                value = value;
              });
            },
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Additional Comments (Optional)',
        border: OutlineInputBorder(),
      ),
      maxLines: 4,
      onChanged: (value) {
        setState(() {
          _comments = value;
        });
      },
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
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
      ),
    );
  }
}
