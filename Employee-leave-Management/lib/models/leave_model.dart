class LeaveModel {
  final String id;
  final String employeeEmail;
  final String employeeName;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final String reason;
  String status;

  LeaveModel({
    required this.id,
    required this.employeeEmail,
    required this.employeeName,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    this.status = 'Pending',
  });

  int get numberOfDays => toDate.difference(fromDate).inDays + 1;
}
