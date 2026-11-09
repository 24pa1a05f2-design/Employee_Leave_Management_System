import 'package:flutter/material.dart';
import '../models/leave_model.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const LeaveCard({
    super.key,
    required this.leave,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    if (leave.status == 'Approved') {
      statusColor = Colors.green;
    } else if (leave.status == 'Rejected') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leave.leaveType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Employee: ${leave.employeeName}'),
            Text('Email: ${leave.employeeEmail}'),
            Text('Reason: ${leave.reason}'),
            Text('Days: ${leave.numberOfDays}'),
            const SizedBox(height: 8),
            Text(
              'Status: ${leave.status}',
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onApprove != null || onReject != null)
              Row(
                children: [
                  if (onApprove != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onApprove,
                        child: const Text('Approve'),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (onReject != null)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onReject,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
