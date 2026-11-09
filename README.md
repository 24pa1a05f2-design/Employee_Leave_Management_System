# Employee Leave Management System

## Project Overview

The Employee Leave Management System is a Flutter-based mobile application developed using Dart. It simplifies employee leave administration by providing separate login facilities for employees and HR.

Employees can register, log in, apply for leave, and view their leave history. HR can manage registered employees, view leave requests, and approve or reject leave applications.

## Objectives

- Provide individual employee registration.
- Implement separate employee and HR login.
- Allow employees to apply for leave.
- Display employee leave history.
- Allow HR to manage registered employees.
- Enable HR to approve or reject leave requests.

## Features

### Employee Module

- Employee registration with name, employee ID, email, and password.
- Individual employee login.
- Employee dashboard.
- Apply for leave.
- View leave history.
- Check leave application status.

### HR Module

- Separate HR login.
- HR dashboard.
- Employee management.
- View all leave requests.
- Approve or reject leave applications.
- Logout functionality.

## Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Frontend development |
| Dart | Programming language |
| Shared Preferences | Local employee data storage |
| JSON | Data serialization |
| SHA-256 | Password hashing |
| Material UI | User interface |
| FlutLab | Development environment |

## System Architecture

```text
          Employee Leave Management
                      |
             Flutter Application
                      |
          -------------------------
          |                       |
     Employee Module          HR Module
          |                       |
     Registration              HR Login
     Employee Login           HR Dashboard
     Apply Leave              Manage Employees
     Leave History            Leave Approval
          |                       |
          -------------------------
                      |
                   Services
                      |
             ----------------
             |              |
        AuthService     LeaveService
             |              |
        SharedPrefs    Leave Records
```

## Project Structure

```text
employee_leave_management/
│
├── lib/
│   ├── main.dart
│   │
│   ├── models/
│   │   └── leave_model.dart
│   │
│   ├── screens/
│   │   ├── welcome_screen.dart
│   │   ├── employee_login.dart
│   │   ├── employee_registration.dart
│   │   ├── employee_dashboard.dart
│   │   ├── hr_login.dart
│   │   ├── hr_dashboard.dart
│   │   ├── employee_management.dart
│   │   ├── leave_requests_screen.dart
│   │   ├── leave_approval_screen.dart
│   │   ├── apply_leave_screen.dart
│   │   └── leave_history_screen.dart
│   │
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── leave_service.dart
│   │
│   └── widgets/
│
├── pubspec.yaml
└── README.md
```

## Employee Login

Employees must register first using their personal details.

After successful registration, they can log in using their registered email address and password.

## How to Run the Project

1. Open the project in FlutLab.
2. Check the `pubspec.yaml` file.
3. Install the required dependencies.
4. Click Pub Get.
5. Click Run to launch the application.

## Dependencies

Add these packages to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.5.3
  crypto: ^3.0.6
```

## Future Enhancements

- Firebase authentication.
- Cloud database integration.
- Employee profile management.
- Leave balance calculation.
- Push notifications.
- Attendance management.
- HR reports and analytics.

## Academic Project Details

- **Project Title:** Employee Leave Management System
- **Programming Language:** Dart
- **Framework:** Flutter
- **Development Environment:** FlutLab
- **Project Type:** Mobile Application
- **Domain:** Human Resource Management

## Developed By

**Student Name:** Merla Hemanth Satyanarayana

**Department:** Computer Science and Engineering

**Institution:** Vishnu Institute of Technology, Bhimavaram
