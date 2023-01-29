import 'package:isar/isar.dart';

import 'course.dart';

part 'student.g.dart';

@Collection()
class Student {
  Student(
      {required this.name,
      required this.regNumber,
      required this.department,
      required this.gender});
  Id id = Isar.autoIncrement;
  late String name;
  late String regNumber;
  late String department;
  late String gender;
  var courses = IsarLinks<Course>();

  // Student.addStudent(this.name, List<Course>>);
}
