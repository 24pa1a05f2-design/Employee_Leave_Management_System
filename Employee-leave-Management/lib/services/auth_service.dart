import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class AuthService {
  static const String _employeesKey = 'employees';

  // HR credentials
  static const String hrEmail = 'hr@company.com';
  static const String hrPassword = 'hr123';

  // Generate password hash
  static String _hashPassword(String salt, String password) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }

  // Generate random salt
  static String _generateSalt() {
    final random = Random.secure();

    return List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }

  // Get registered employees
  static Future<List<Map<String, dynamic>>> _getEmployees() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(_employeesKey);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;

    return decoded.map((item) => Map<String, dynamic>.from(item)).toList();
  }

  // Employee Registration
  static Future<String?> registerEmployee({
    required String name,
    required String employeeId,
    required String email,
    required String password,
  }) async {
    final employees = await _getEmployees();

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedId = employeeId.trim();

    if (employees.any((e) => e['email'] == normalizedEmail)) {
      return 'Email already registered';
    }

    if (employees.any((e) => e['employeeId'] == normalizedId)) {
      return 'Employee ID already registered';
    }

    final salt = _generateSalt();

    employees.add({
      'name': name.trim(),
      'employeeId': normalizedId,
      'email': normalizedEmail,
      'salt': salt,
      'passwordHash': _hashPassword(salt, password),
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _employeesKey,
      jsonEncode(employees),
    );

    return null;
  }

  // Employee Login
  static Future<Map<String, dynamic>?> loginEmployee({
    required String email,
    required String password,
  }) async {
    final employees = await _getEmployees();

    final normalizedEmail = email.trim().toLowerCase();

    for (final employee in employees) {
      if (employee['email'] == normalizedEmail) {
        final salt = employee['salt'] as String;

        if (employee['passwordHash'] == _hashPassword(salt, password)) {
          return employee;
        }
      }
    }

    return null;
  }

  // HR Login
  static Future<bool> loginHR({
    required String email,
    required String password,
  }) async {
    return email.trim().toLowerCase() == hrEmail && password == hrPassword;
  }

  // Get all registered employees for HR
  static Future<List<Map<String, dynamic>>> getRegisteredEmployees() async {
    return await _getEmployees();
  }
}
