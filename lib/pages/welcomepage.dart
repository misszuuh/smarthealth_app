
import 'package:flutter/material.dart';
import 'heartrate_page.dart';
import 'personalization_page.dart';
import 'bloodpressure.dart';

class WelcomePage extends StatelessWidget {
  final String username;

  const WelcomePage({super.key, required this.username, required String role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Health Dashboard', 
               style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFE75480),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildWelcomeCard(),
                const SizedBox(height: 24),
                _buildQuickAccessCard(context),
                const SizedBox(height: 24),
                _buildHealthServicesCard(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildRomanticBottomNavBar(),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE75480), Color(0xFFFE7BE5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withAlpha(51),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person, size: 30, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome Back,', 
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.white70,
                      fontStyle: FontStyle.italic)),
                  Text(username,
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFFCE4EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final buttonSize = constraints.maxWidth / 3 - 24;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureButton(
                    size: buttonSize,
                    icon: Icons.favorite,
                    label: "Heart Rate",
                    color: Colors.red,
                    onPressed: () => Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => HeartRatePage())),
                  ),
                  _featureButton(
                    size: buttonSize,
                    icon: Icons.bloodtype,
                    label: "Blood Pressure",
                    color: Colors.pink,
                    onPressed: () => Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => BloodPressurePage())),
                  ),
                  _featureButton(
                    size: buttonSize,
                    icon: Icons.person,
                    label: "Profile",
                    color: Colors.purple,
                    onPressed: () => Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => PersonalizationPage())),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHealthServicesCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFFCE4EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Health Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE75480))),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _buildServiceCard(
                    icon: Icons.medical_services,
                    title: 'Medical Reminder',
                    color: Colors.red,
                  ),
                  _buildServiceCard(
                    icon: Icons.chat,
                    title: 'Chat with Doctor',
                    color: Colors.pink,
                  ),
                  _buildServiceCard(
                    icon: Icons.restaurant,
                    title: 'Food Recommendation',
                    color: Colors.purple,
                  ),
                  _buildServiceCard(
                    icon: Icons.history,
                    title: 'Historical Data',
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _featureButton({
    required double size,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: size,
      child: Column(
        children: [
          Container(
            width: size - 20,
            height: size - 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(76),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(icon, size: size * 0.3, color: color),
              onPressed: onPressed,
            ),
          ),
          const SizedBox(height: 8),
          Text(label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildRomanticBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, 
            spreadRadius: 0, 
            blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: const Color(0xFFE75480),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}