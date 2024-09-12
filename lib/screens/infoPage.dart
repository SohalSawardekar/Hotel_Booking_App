import 'package:hotel_booking/constants/ImportFiles.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();

  String _selectedGender = 'Male'; // Default value for gender dropdown
  DateTime _selectedDate = DateTime.now(); // Default value for birthdate

  // Function to update Firestore
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': _nameController.text,
          'phoneNo': _phoneController.text,
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
        _birthdateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format date to YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get screen size for responsiveness
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var padding = screenWidth * 0.05; // 5% of screen width as padding
    var textFieldFontSize =
        screenWidth * 0.045; // Adjusting font size based on width

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Info',
            style: TextStyle(fontSize: screenWidth * 0.06)),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding), // Apply dynamic padding
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
              SizedBox(
                  height: screenHeight * 0.05), // Adjust spacing dynamically
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.1,
                  ),
                ),
                child: Text('Update Profile',
                    style: TextStyle(fontSize: screenWidth * 0.05)),
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
        decoration: InputDecoration(labelText: label),
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
        decoration: InputDecoration(labelText: 'Gender'),
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
        ),
        style: TextStyle(fontSize: fontSize),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your birthdate';
          }
          return null;
        },
        readOnly: true, // Prevent manual input
      ),
    );
  }
}
