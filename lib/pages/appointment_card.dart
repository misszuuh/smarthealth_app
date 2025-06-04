import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Safe date parsing with fallback
    DateTime? appointmentDate;
    try {
      appointmentDate = DateTime.parse(appointment['date'] ?? '');
    } catch (e) {
      appointmentDate = DateTime.now();
    }

    final date = DateFormat('MMM d, yyyy').format(appointmentDate);
    final time = appointment['time']?.toString() ?? '--:--';
    final patientName = appointment['patientName']?.toString() ?? 'Unknown Patient';
    final status = appointment['status']?.toString() ?? 'Scheduled';
    final reason = appointment['reason']?.toString() ?? 'General Checkup';
    
    Color statusColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'cancelled':
        statusColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      case 'confirmed':
        statusColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        break;
      default:
        statusColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,      
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patientName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Reason: $reason',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(date, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(time, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}