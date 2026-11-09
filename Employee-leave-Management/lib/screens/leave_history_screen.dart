import 'package:flutter/material.dart';
import '../services/leave_service.dart';
import '../widgets/leave_card.dart';

class LeaveHistoryScreen extends StatelessWidget {
  final String employeeEmail;

  const LeaveHistoryScreen({
    super.key,
    required this.employeeEmail,
  });

  @override
  Widget build(BuildContext context) {
    final leaves = LeaveService.forEmployee(employeeEmail);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave History'),
      ),
      body: leaves.isEmpty
          ? const Center(
              child: Text('No leave history available'),
            )
          : ListView.builder(
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                return LeaveCard(
                  leave: leaves[index],
                );
              },
            ),
    );
  }
}
