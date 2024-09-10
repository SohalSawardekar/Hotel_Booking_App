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
            scaffoldBackgroundColor: Colors.blueGrey[900],
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.orange[200]),
              bodyMedium: TextStyle(color: Colors.orange[200]),
            ),
          ),
          themeMode: themeNotifier.currentTheme,
          home: const AuthWrapper(), 
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => LoginPage(),
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => LoginPage(),
            );
          },
        );
      },
    );
  }
}

