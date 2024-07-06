import 'package:flutter/material.dart';
//import'package:on_time/pages/welcome.dart';
import 'package:on_time/styles/common_styles.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    //importing the style for the page, the gradient.
    //var gradient = CommonStyles.backgroundGradient;
    return Scaffold(
      backgroundColor: CommonStyles.backgroundGradient.colors[0],
      appBar: AppBar(
        backgroundColor: CommonStyles.backgroundGradient.colors[1],
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          const Text('Hello')
        ]),
      ),
    );
  }
}
