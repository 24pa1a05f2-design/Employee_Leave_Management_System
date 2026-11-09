import 'package:flutter/material.dart';
import '../services/leave_service.dart';
import '../widgets/leave_card.dart';
import 'apply_leave_screen.dart' as apply_leave;
import 'leave_history_screen.dart';
import 'welcome_screen.dart';

class EmployeeDashboardScreen extends StatefulWidget {
  final String employeeEmail;
  final String employeeName;

  const EmployeeDashboardScreen({
    super.key,
    required this.employeeEmail,
    required this.employeeName,
  });

  @override
  State<EmployeeDashboardScreen> createState() =>
      _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends State<EmployeeDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final leaves = LeaveService.forEmployee(widget.employeeEmail);
    final pending = leaves.where((leave) => leave.status == 'Pending').length;
    final approved = leaves.where((leave) => leave.status == 'Approved').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const WelcomeScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Welcome, ${widget.employeeName}!',
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(widget.employeeEmail),
          const SizedBox(height: 20),
          Row(
            children: [
              _summary('Total', leaves.length, Colors.blue),
              _summary('Pending', pending, Colors.orange),
              _summary('Approved', approved, Colors.green),
            ],
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Apply for Leave'),
            onPressed: () async {
              await Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => apply_leave.ApplyLeaveScreen(
                    employeeEmail: widget.employeeEmail,
                    employeeName: widget.employeeName,
                  ),
                ),
              );

              if (mounted) {
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            icon: const Icon(Icons.history),
            label: const Text('View Leave History'),
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => LeaveHistoryScreen(
                    employeeEmail: widget.employeeEmail,
                  ),
                ),
              ).then((_) {
                if (mounted) {
                  setState(() {});
                }
              });
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Recent Leave Requests',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (leaves.isEmpty)
            const Text('No leave requests yet.')
          else
            ...leaves.take(3).map((leave) => LeaveCard(leave: leave)),
        ],
      ),
    );
  }

  Widget _summary(String title, int count, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                '$count',
                style: TextStyle(
                  color: color,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
