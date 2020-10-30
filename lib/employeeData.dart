import 'dart:convert';

class EmployeeData {
  // ignore: non_constant_identifier_names
  final String employee_name;
  // ignore: non_constant_identifier_names
  final int employee_salary;
  // ignore: non_constant_identifier_names
  final int id;
  // ignore: non_constant_identifier_names
  final int employee_age;
  // ignore: non_constant_identifier_names
  final String profile_image;

  EmployeeData({
    // ignore: non_constant_identifier_names
    this.employee_name,
    // ignore: non_constant_identifier_names
    this.employee_salary,
    // ignore: non_constant_identifier_names
    this.id,
    // ignore: non_constant_identifier_names
    this.employee_age,
    // ignore: non_constant_identifier_names
    this.profile_image,
  });

  Map<String, dynamic> toMap() {
    return {
      'employee_name': employee_name,
      'employee_salary': employee_salary,
      'id': id,
      'employee_age': employee_age,
      'profile_image': profile_image,
    };
  }

  factory EmployeeData.fromMap(dynamic map) {
    if (map == null) return null;

    return EmployeeData(
      employee_name: map['employee_name'],
      employee_salary: map['employee_salary'],
      id: map['id'],
      employee_age: map['employee_age'],
      profile_image: map['profile_image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeData.fromJson(String source) =>
      EmployeeData.fromMap(json.decode(source));
}
