// lib/models/student.dart
class Student {
  String name;
  String id;
  double gpa;

  Student({required this.name, required this.id, required this.gpa});

  Map<String, dynamic> toMap() {
    return {
      'studentName': name,
      'studentID': id,
      'studentCGPA': gpa,
    };
  }

  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['studentName'],
      id: map['studentID'],
      gpa: map['studentCGPA'],
    );
  }
}
