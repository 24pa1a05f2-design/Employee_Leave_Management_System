import 'package:flutter/material.dart';
import '../services/leave_service.dart';

class LeaveRequestsScreen extends StatelessWidget {
  const LeaveRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaves = LeaveService.allLeaves;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: leaves.isEmpty
          ? const Center(
              child: Text('No leave requests available'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                final leave = leaves[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.event_note,
                      color: Colors.orange,
                      size: 35,
                    ),
                    title: Text(leave.employeeName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${leave.employeeEmail}'),
                        Text('Type: ${leave.leaveType}'),
                        Text(
                            'From: ${leave.fromDate.toString().split(' ')[0]}'),
                        Text('To: ${leave.toDate.toString().split(' ')[0]}'),
                        Text('Reason: ${leave.reason}'),
                        Text('Status: ${leave.status}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
