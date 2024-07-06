import 'package:flutter/material.dart';
import 'package:on_time/pages/homepage.dart';
import 'package:on_time/styles/common_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return welcomeBoardingUI(context, CommonStyles.backgroundGradient);
  }

  Container welcomeBoardingUI(BuildContext context, LinearGradient gradient) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.98,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 140, 12, 110),
        child: Column(
          children: [
            Column(
              children: [
                  const Text(
                  'on.time',
                  style: TextStyle(
                      fontSize: 75,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontFamily: 'Montserrat'),
                ),
                const SizedBox(height: 200),
                const SizedBox(
                  child: Center(
                    child: Text(
                      'Make yourself\n more on time',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontFamily: 'Open Sans'),
                      //overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 170),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboarded', true);
                    //print('Clicked!');
                    //navigating to homepage (dashboard.dart)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashBoard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(325, 60),
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A0416),
                        fontFamily: 'Montserrat'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
