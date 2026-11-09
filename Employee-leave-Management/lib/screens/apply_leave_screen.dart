import 'package:flutter/material.dart';
import '../models/leave_model.dart';
import '../services/leave_service.dart';

class ApplyLeaveScreen extends StatefulWidget {
  final String employeeEmail;
  final String employeeName;

  const ApplyLeaveScreen({
    super.key,
    required this.employeeEmail,
    required this.employeeName,
  });

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final reasonController = TextEditingController();

  String leaveType = 'Casual Leave';

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> selectDate(bool isFrom) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selected != null) {
      setState(() {
        if (isFrom) {
          fromDate = selected;
          if (toDate != null && toDate!.isBefore(selected)) {
            toDate = null;
          }
        } else {
          toDate = selected;
        }
      });
    }
  }

  void submitLeave() {
    if (fromDate == null ||
        toDate == null ||
        reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields'),
        ),
      );
      return;
    }

    if (toDate!.isBefore(fromDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('End date must be after start date'),
        ),
      );
      return;
    }

    final leave = LeaveModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      employeeEmail: widget.employeeEmail,
      employeeName: widget.employeeName,
      leaveType: leaveType,
      fromDate: fromDate!,
      toDate: toDate!,
      reason: reasonController.text.trim(),
    );

    LeaveService.addLeave(leave);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Leave request submitted successfully'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for Leave'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Leave Application Form',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          DropdownButtonFormField<String>(
            value: leaveType,
            decoration: const InputDecoration(
              labelText: 'Leave Type',
              border: OutlineInputBorder(),
            ),
            items: [
              'Casual Leave',
              'Sick Leave',
              'Annual Leave',
              'Emergency Leave',
            ].map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                leaveType = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () => selectDate(true),
            icon: const Icon(Icons.calendar_today),
            label: Text(
              fromDate == null
                  ? 'Select Start Date'
                  : 'From: ${fromDate!.day}/${fromDate!.month}/${fromDate!.year}',
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => selectDate(false),
            icon: const Icon(Icons.event),
            label: Text(
              toDate == null
                  ? 'Select End Date'
                  : 'To: ${toDate!.day}/${toDate!.month}/${toDate!.year}',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: reasonController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Reason for Leave',
              hintText: 'Enter your reason...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: submitLeave,
              child: const Text('Submit Leave Request'),
            ),
          ),
        ],
      ),
    );
  }
}
