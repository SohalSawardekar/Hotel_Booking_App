import 'constants/ImportFiles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
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
          ),
          themeMode: themeNotifier.currentTheme,
          home: const AuthWrapper(),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginPage(),
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
