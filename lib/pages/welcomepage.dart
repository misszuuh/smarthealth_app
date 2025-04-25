import 'package:flutter/material.dart';
import 'heartrate_page.dart';
import 'personalization_page.dart';
import 'bloodpressure.dart';

class WelcomePage extends StatelessWidget {
  final String username;

  const WelcomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top Section with Curve and Welcome Message
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(fontSize: 22, color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Icon Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _featureButton(
                      icon: Icons.favorite,
                      label: "Heart Rate",
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeartRatePage(),
                          ),
                        );
                        _showMessage(context, 'Heart Rate Condition');
                      },
                    ),
                    _featureButton(
                      icon: Icons.bloodtype,
                      label: "Blood Pressure", // Fixed label
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BloodPressurePage(),
                          ),
                        );
                        _showMessage(context, 'Blood Pressure Condition');
                      },
                    ),
                    _featureButton(
                      icon: Icons.person,
                      backgroundColor: Colors.blue,
                      label: "Personalize",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalizationPage(),
                          ),
                        );
                        _showMessage(context, 'Personalization Settings');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required MaterialColor backgroundColor,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: backgroundColor, // Use the passed color
          ),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}