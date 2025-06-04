import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'appointment_card.dart';
import 'patient_card.dart';
import 'profile_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _currentIndex = 0;
  
  // Mock doctor data
  final Map<String, dynamic> _mockDoctor = {
    'name': 'Sarah Johnson',
    'specialization': 'Cardiologist',
    'upcomingAppointments': 5,
    'totalPatients': 24,
    'unreadMessages': 3,
  };

  // Mock appointments data
  final List<Map<String, dynamic>> _mockAppointments = [
    {
      'id': '1',
      'patientName': 'John Doe',
      'date': '2023-06-15',
      'time': '09:30 AM',
      'reason': 'Heart checkup',
      'status': 'Scheduled',
    },
    {
      'id': '2',
      'patientName': 'Mary Smith',
      'date': '2023-06-15',
      'time': '10:45 AM',
      'reason': 'Follow-up',
      'status': 'Confirmed',
    },
    {
      'id': '3',
      'patientName': 'Robert Johnson',
      'date': '2023-06-15',
      'time': '02:15 PM',
      'reason': 'Annual physical',
      'status': 'Completed',
    },
  ];

  // Mock patients data
  final List<Map<String, dynamic>> _mockPatients = [
    {
      'id': '1',
      'name': 'John Doe',
      'lastVisit': '2023-06-10',
      'age': 45,
      'gender': 'Male',
    },
    {
      'id': '2',
      'name': 'Mary Smith',
      'lastVisit': '2023-06-08',
      'age': 32,
      'gender': 'Female',
    },
    {
      'id': '3',
      'name': 'Robert Johnson',
      'lastVisit': '2023-06-05',
      'age': 58,
      'gender': 'Male',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: Colors.blue[800],
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _navigateToAddAppointment(),
            )
          : null,
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboard();
      case 1:
        return _buildAppointments();
      case 2:
        return ProfileScreen(userId: 'mock-user-id');
      default:
        return _buildDashboard();
    }
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          const SizedBox(height: 20),
          _buildTodayAppointments(),
          const SizedBox(height: 20),
          _buildRecentPatients(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    final greeting = _getGreeting();
    final name = _mockDoctor['name'] ?? 'Doctor';
    final specialization = _mockDoctor['specialization'] ?? 'General Practitioner';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$greeting, Dr. $name',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(specialization,
                style: TextStyle(
                    fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Upcoming', _mockDoctor['upcomingAppointments'].toString(), Icons.calendar_today),
                _buildStatCard('Patients', _mockDoctor['totalPatients'].toString(), Icons.people),
                _buildStatCard('Messages', _mockDoctor['unreadMessages'].toString(), Icons.message),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue[800]),
        ),
        const SizedBox(height: 8),
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTodayAppointments() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final todaysAppointments = _mockAppointments.where((appt) => appt['date'] == today).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Today\'s Appointments',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        todaysAppointments.isEmpty
            ? const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No appointments scheduled for today'),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todaysAppointments.length,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    appointment: todaysAppointments[index],
                    onTap: () => _navigateToAppointmentDetail(todaysAppointments[index]['id']),
                  );
                },
              ),
      ],
    );
  }

  Widget _buildRecentPatients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Patients',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _mockPatients.length,
          itemBuilder: (context, index) {
            return PatientCard(
              patient: _mockPatients[index],
              onTap: () => _navigateToPatientDetail(_mockPatients[index]['id']),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAppointments() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _mockAppointments.length,
      itemBuilder: (context, index) {
        return AppointmentCard(
          appointment: _mockAppointments[index],
          onTap: () => _navigateToAppointmentDetail(_mockAppointments[index]['id']),
        );
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void _navigateToPatientDetail(String patientId) {
    // Implement patient detail navigation
    final patient = _mockPatients.firstWhere((p) => p['id'] == patientId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(patient['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: ${patient['age']}'),
            Text('Gender: ${patient['gender']}'),
            Text('Last Visit: ${patient['lastVisit']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToAppointmentDetail(String appointmentId) {
    final appointment = _mockAppointments.firstWhere((a) => a['id'] == appointmentId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Appointment Details')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Patient: ${appointment['patientName']}', 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Text('Date: ${appointment['date']}'),
                Text('Time: ${appointment['time']}'),
                Text('Reason: ${appointment['reason']}'),
                const SizedBox(height: 16),
                Chip(
                  label: Text(appointment['status']),
                  backgroundColor: _getStatusColor(appointment['status']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green[100]!;
      case 'cancelled':
        return Colors.red[100]!;
      case 'confirmed':
        return Colors.blue[100]!;
      default:
        return Colors.orange[100]!;
    }
  }

  void _navigateToAddAppointment() {
    // Implement add appointment
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Appointment'),
        content: const Text('This would open a form to add new appointment in the real app.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}