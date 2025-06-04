import 'package:flutter/material.dart';

class MedicalReminderPage extends StatefulWidget {
  const MedicalReminderPage({super.key});

  @override
  State<MedicalReminderPage> createState() => _MedicalReminderPageState();
}

class _MedicalReminderPageState extends State<MedicalReminderPage> {
  final List<MedicineReminder> _reminders = [];
  final TextEditingController _medicineController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    setState(() {
      _reminders.addAll([
        MedicineReminder(
          medicineName: 'Ibuprofen',
          time: const TimeOfDay(hour: 8, minute: 0),
          dosage: '200mg',
          isActive: true,
        ),
        MedicineReminder(
          medicineName: 'Vitamin D',
          time: const TimeOfDay(hour: 12, minute: 0),
          dosage: '1000IU',
          isActive: true,
        ),
      ]);
    });
  }

  void _showReminderAlert(MedicineReminder reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Medicine Reminder'),
        content: Text('Time to take ${reminder.medicineName} (${reminder.dosage})'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addReminder() {
    if (_medicineController.text.isEmpty) return;

    final newReminder = MedicineReminder(
      medicineName: _medicineController.text,
      time: _selectedTime,
      dosage: '1 pill',
      isActive: true,
    );

    setState(() {
      _reminders.add(newReminder);
      _medicineController.clear();
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added reminder for ${newReminder.medicineName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleReminder(int index, bool isActive) {
    setState(() {
      _reminders[index].isActive = isActive;
    });
    
    // Show status change feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder ${isActive ? 'activated' : 'deactivated'}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Reminders'),
        backgroundColor: const Color(0xFFE75480),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _medicineController,
                  decoration: const InputDecoration(
                    labelText: 'Medicine Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_selectedTime.format(context)),
                              const Icon(Icons.access_time),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE75480),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      ),
                      onPressed: _addReminder,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.medical_services,
                      color: Color(0xFFE75480)),
                    title: Text(reminder.medicineName),
                    subtitle: Text(
                      '${reminder.time.format(context)} - ${reminder.dosage}'),
                    trailing: Switch(
                      value: reminder.isActive,
                      onChanged: (value) =>
                          _toggleReminder(index, value),
                      activeColor: const Color(0xFFE75480),
                    ),
                    onTap: () => _showReminderAlert(reminder),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MedicineReminder {
  final String medicineName;
  final TimeOfDay time;
  final String dosage;
  bool isActive;

  MedicineReminder({
    required this.medicineName,
    required this.time,
    required this.dosage,
    required this.isActive,
  });
}