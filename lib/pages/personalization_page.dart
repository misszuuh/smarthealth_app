import 'package:flutter/material.dart';

// import 'reminder_page.dart';

class PersonalizationPage extends StatelessWidget {
const PersonalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personalization")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildCard(
            icon: Icons.alarm,
            title: "Medicine Reminder",
            subtitle: "Set reminder to take your medicine",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ReminderPage()),
              //   );
              // Navigate to reminder setup
            },
          ),
          _buildCard(
            icon: Icons.restaurant_menu,
            title: "Food Recommendation",
            subtitle: "Get recommended foods for your condition",
            onTap: () {
              // Show food recommendations
            },
          ),
          _buildCard(
            icon: Icons.chat,
            title: "Chat with Doctor",
            subtitle: "Consult your doctor easily",
            onTap: () {
              // Open chat interface
            },
          ),
          _buildCard(
            icon: Icons.history,
            title: "Historical Data",
            subtitle: "View your health history and trends",
            onTap: () {
              // Navigate to historical data page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.blue),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
