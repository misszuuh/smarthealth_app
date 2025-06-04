import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patient;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String lastVisit;
    
    try {
      if (patient['lastVisit'] == null) {
        lastVisit = 'Never visited';
      } else if (patient['lastVisit'] is String) {
        // Handle string date format
        final date = DateTime.parse(patient['lastVisit']);
        lastVisit = DateFormat('MMM d, yyyy').format(date);
      } else {
        // Handle Firestore Timestamp
        lastVisit = DateFormat('MMM d, yyyy')
            .format((patient['lastVisit'] as Timestamp).toDate());
      }
    } catch (e) {
      lastVisit = 'Date error';
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
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue[100],
                child: Text(
                  patient['name']?.toString().isNotEmpty ?? false 
                      ? patient['name'][0].toString().toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient['name']?.toString() ?? 'Unknown Patient',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Age: ${patient['age']?.toString() ?? 'N/A'} | ${patient['gender']?.toString() ?? ''}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Last Visit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    lastVisit,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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
}