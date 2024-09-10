import 'package:hotel_booking/constants/ImportFiles.dart';

class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final Future<User?> Function() loginMethod;
  final double iconSize;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
    required this.loginMethod,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton.icon(
        onPressed: () async {
          User? user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            var message = 'An error occurred. Please try again.';
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          }
        },
        iconAlignment: IconAlignment.end,
        icon: Image.asset(imagePath, height: iconSize),
        label: const Text(""),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
