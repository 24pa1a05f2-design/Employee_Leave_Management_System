import 'package:flutter/material.dart';

import 'employee_management.dart';
import 'leave_requests_screen.dart';
import 'leave_approval_screen.dart';

class HRDashboardScreen extends StatelessWidget {
  const HRDashboardScreen({super.key});

  Widget dashboardCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required Widget screen,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(icon, color: color, size: 38),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(subtitle),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HR Dashboard'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome HR!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Employee Leave Management System',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            dashboardCard(
              context: context,
              icon: Icons.people,
              color: Colors.blue,
              title: 'Employee Management',
              subtitle: 'Manage registered employees',
              screen: const EmployeeManagementScreen(),
            ),
            dashboardCard(
              context: context,
              icon: Icons.event_note,
              color: Colors.orange,
              title: 'Leave Requests',
              subtitle: 'View employee leave requests',
              screen: const LeaveRequestsScreen(),
            ),
            dashboardCard(
              context: context,
              icon: Icons.check_circle,
              color: Colors.green,
              title: 'Leave Approval',
              subtitle: 'Approve or reject leave requests',
              screen: const LeaveApprovalScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
