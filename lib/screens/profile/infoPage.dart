import 'package:hotel_booking/constants/ImportFiles.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  String _selectedGender = 'Male';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            _nameController.text = data['name'] ?? '';
            _phoneController.text = data['mobileNo'] ?? '';
            _addressController.text = data['address'] ?? '';
            _ageController.text = data['age'] ?? '';
            _selectedGender = data['gender'] ?? 'Male';
            _birthdateController.text = data['birthdate'] ?? '';
            _selectedDate =
                DateFormat('yyyy-MM-dd').parse(_birthdateController.text);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching profile data: $e')),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        try {
          await _firestore.collection('users').doc(user.uid).set({
            'name': _nameController.text,
            'mobileNo': _phoneController.text,
            'address': _addressController.text,
            'age': _ageController.text,
            'gender': _selectedGender,
            'birthdate': _birthdateController.text,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile: $e')),
          );
        }
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var padding = screenWidth * 0.05;
    var textFieldFontSize = screenWidth * 0.045;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Info',
          style: TextStyle(fontSize: screenWidth * 0.06),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Name', _nameController, textFieldFontSize),
              _buildTextField(
                  'Phone Number', _phoneController, textFieldFontSize),
              _buildTextField('Address', _addressController, textFieldFontSize),
              _buildTextField('Age', _ageController, textFieldFontSize),
              _buildGenderDropdown(textFieldFontSize),
              _buildDateField(textFieldFontSize),
              SizedBox(height: screenHeight * 0.05),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.1,
                  ),
                ),
                child: Text(
                  'Update Profile',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(fontSize: fontSize),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown(double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue!;
          });
        },
        items: <String>['Male', 'Female', 'Other']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(fontSize: fontSize)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateField(double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: _birthdateController,
        decoration: InputDecoration(
          labelText: 'Birthdate',
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: TextStyle(fontSize: fontSize),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your birthdate';
          }
          return null;
        },
        readOnly: true,
      ),
    );
  }
}
