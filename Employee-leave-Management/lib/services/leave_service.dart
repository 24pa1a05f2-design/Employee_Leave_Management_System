import '../models/leave_model.dart';

class LeaveService {
  static final List<LeaveModel> _leaves = [];

  static List<LeaveModel> get allLeaves => List.unmodifiable(_leaves);

  static List<LeaveModel> forEmployee(String email) {
    return _leaves
        .where(
            (leave) => leave.employeeEmail.toLowerCase() == email.toLowerCase())
        .toList()
      ..sort((a, b) => b.fromDate.compareTo(a.fromDate));
  }

  static void addLeave(LeaveModel leave) {
    _leaves.add(leave);
  }

  static void updateStatus(String id, String newStatus) {
    final index = _leaves.indexWhere((leave) => leave.id == id);

    if (index != -1) {
      _leaves[index].status = newStatus;
    }
  }
}
