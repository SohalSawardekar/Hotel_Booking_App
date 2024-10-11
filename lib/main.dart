import 'constants/ImportFiles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase  .initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Hotel Booking",
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 19, 25, 28),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              bodyMedium: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 19, 25, 28),
              titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
              ),
              iconTheme:
                  IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                iconColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color.fromARGB(255, 30, 35, 38),
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 150, 150, 150)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 50, 55, 60)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 100, 150, 200)),
              ),
            ),
          ),
          themeMode: themeNotifier.currentTheme,
          home: const AuthWrapper(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginPage(),
            '/contactUs': (context) => const ContactUs(),
            '/profileEdit': (context) => const ProfileInfoPage(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
          },
        );
      },
    );
  }
}
