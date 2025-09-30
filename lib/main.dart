import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mindful_journal/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/entry_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EntryProvider())],
      child: MaterialApp(
        title: 'Mindful Journal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          useMaterial3: true, // Modern Material Design 3
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system, // Follow system theme
        home: const HomeScreen(),
      ),
    );
  }
}
