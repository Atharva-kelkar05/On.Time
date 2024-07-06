import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:on_time/pages/welcome.dart';
import 'package:on_time/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool onboarded = prefs.getBool('onboarded') ?? false;
  runApp(MyApp(onboarded: onboarded));
}

class MyApp extends StatelessWidget {
  final bool onboarded;
  const MyApp({super.key, required this.onboarded});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'on.time',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError && snapshot.hasData) {
              final prefs = snapshot.data!;
              final onboarded = prefs.getBool('onboarded') ?? false;
              // If onboarded, go to DashBoard, else show WelcomePage
              return onboarded ? const DashBoard() : const WelcomePage();
            } else {
              // Handle error or data not available scenario
              return const WelcomePage(); // Fallback to WelcomePage
            }
          } else {
            // Show loading indicator while waiting for SharedPreferences
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
