import 'package:flutter/material.dart';
import 'chatbot_page.dart';
import 'heartrate_page.dart';
import 'bloodpressure.dart';
import 'food_recommendation_page.dart';
import 'medical_reminder_page.dart';
import 'historical_data_page.dart';

class WelcomePage extends StatelessWidget {
  final String username;
  final String role;

  const WelcomePage({super.key, required this.username, required this.role});

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
        leading: Builder(
          builder: (BuildContext scaffoldContext) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(scaffoldContext).openDrawer();
              },
            );
          },
        ),
        actions: [
          // You can add more action buttons here if needed
        ],
      ),
      drawer: _buildSideMenu(context),
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
                _buildHealthServicesCard(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildRomanticBottomNavBar(),
    );
  }
Widget _buildSideMenu(BuildContext context) {
  return Drawer(
    width: MediaQuery.of(context).size.width * 0.85,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.pink,
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Header Section
          Container(
            height: 220,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE75480), Color(0xFFFE7BE5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                role,
                                style: const TextStyle(
                                  fontSize: 12, 
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Health summary chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildHealthChip(Icons.favorite, 'Heart Rate', '72 bpm'),
                        const SizedBox(width: 8),
                        _buildHealthChip(Icons.bloodtype, 'BP', '120/80'),
                        const SizedBox(width: 8),
                        _buildHealthChip(Icons.monitor_weight, 'Weight', '68 kg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Menu Items Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Profile Expansion Tile
                  ExpansionTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE75480),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.person, color: Color(0xFFE75480)),
                    ),
                    title: const Text(
                      'My Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    children: [
                      _buildProfileDetailItem('Name', 'Ally Nurdin'),
                      _buildProfileDetailItem('Email', 'ally@gmail.com'),
                      _buildProfileDetailItem('Phone', '+1234567890'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Edit profile functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE75480),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 40),
                          ),
                          child: const Text('Edit Profile'),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  
                  // Account Settings Expansion Tile
                  ExpansionTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE75480),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.settings, color: Color(0xFFE75480)),
                    ),
                    title: const Text(
                      'Account Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    children: [
                      SwitchListTile(
                        title: const Text('Dark Mode'),
                        value: false,
                        onChanged: (value) {},
                        activeColor: const Color(0xFFE75480),
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock, color: Colors.grey),
                        title: const Text('Change Password'),
                        onTap: () {
                          _showChangePasswordDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip, color: Colors.grey),
                        title: const Text('Privacy Settings'),
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to privacy settings
                        },
                      ),
                    ],
                  ),
                  
                  // Help & Support
                  _buildMenuTile(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'FAQs and contact information',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to help & support
                    },
                  ),
                  
                  const Divider(height: 30, indent: 20, endIndent: 20, thickness: 0.5),
                  
                  // Logout
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      child: _buildMenuTile(
                        context,
                        icon: Icons.logout,
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        onTap: () {
                          _showLogoutConfirmation(context);
                        },
                        textColor: Colors.red,
                        iconColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper methods for the side menu
Widget _buildHealthChip(IconData icon, String title, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildProfileDetailItem(String label, String value) {
  return ListTile(
    title: Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    ),
    subtitle: Text(
      value,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
  );
}

void _showChangePasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Change Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Current Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm New Password',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE75480),
          ),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

void _showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Close drawer
            // Add your logout logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}


Widget _buildMenuTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  Color? textColor,
  Color? iconColor,
}) {
  return ListTile(
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE75480),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor ?? const Color(0xFFE75480)),
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor ?? Colors.black87,
      ),
    ),
    subtitle: Text(
      subtitle,
      style: TextStyle(
        fontSize: 12,
        color: (textColor ?? Colors.black54),
      ),
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                  const Text(
                    'Welcome Back,', 
                    style: TextStyle(
                      fontSize: 16, 
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
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
                      context, 
                      MaterialPageRoute(builder: (context) => HeartRatePage()),
                    ),
                  ),
                  _featureButton(
                    size: buttonSize,
                    icon: Icons.bloodtype,
                    label: "Blood Pressure",
                    color: Colors.pink,
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => BloodPressurePage()),
                    ),
                  ),
                  _featureButton(
                    size: buttonSize,
                    icon: Icons.person,
                    label: "Profile",
                    color: Colors.purple, onPressed: () {  },
                    // onPressed: () => Navigator.push(
                    //   context, 
                    //   MaterialPageRoute(builder: (context) => ProfileuserPage()),
                    // ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHealthServicesCard(BuildContext context) {
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
              const Text(
                'Health Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE75480),
                ),
              ),
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MedicalReminderPage()),
                    ),
                  ),
                  _buildServiceCard(
                    icon: Icons.chat,
                    title: 'Chat with Doctor',
                    color: Colors.pink,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatbotPage()),
                    ),
                  ),
                  _buildServiceCard(
                    icon: Icons.restaurant,
                    title: 'Food Recommendation',
                    color: Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FoodRecommendationPage()),
                    ),
                  ),
                  _buildServiceCard(
                    icon: Icons.history,
                    title: 'Historical Data',
                    color: Colors.deepOrange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HistoricalDataPage()),
                    ),
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
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
            ],
          ),
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
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRomanticBottomNavBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, 
            spreadRadius: 0, 
            blurRadius: 10,
          ),
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