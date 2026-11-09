import 'package:flutter/material.dart';
import '../services/leave_service.dart';

class LeaveApprovalScreen extends StatefulWidget {
  const LeaveApprovalScreen({super.key});

  @override
  State<LeaveApprovalScreen> createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen> {
  void updateLeave(String id, String status) {
    setState(() {
      LeaveService.updateStatus(id, status);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Leave $status successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leaves = LeaveService.allLeaves;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Approval'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: leaves.isEmpty
          ? const Center(
              child: Text('No leave applications available'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: leaves.length,
              itemBuilder: (context, index) {
                final leave = leaves[index];

                final isPending = leave.status.toLowerCase() == 'pending';

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leave.employeeName,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Email: ${leave.employeeEmail}'),
                        Text('Leave Type: ${leave.leaveType}'),
                        Text(
                            'From: ${leave.fromDate.toString().split(' ')[0]}'),
                        Text('To: ${leave.toDate.toString().split(' ')[0]}'),
                        Text('Reason: ${leave.reason}'),
                        const SizedBox(height: 10),
                        Text(
                          'Status: ${leave.status}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: leave.status == 'Approved'
                                ? Colors.green
                                : leave.status == 'Rejected'
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ),
                        if (isPending) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => updateLeave(
                                    leave.id,
                                    'Approved',
                                  ),
                                  icon: const Icon(Icons.check),
                                  label: const Text('Approve'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => updateLeave(
                                    leave.id,
                                    'Rejected',
                                  ),
                                  icon: const Icon(Icons.close),
                                  label: const Text('Reject'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
