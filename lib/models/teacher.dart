import 'package:isar/isar.dart';

import 'course.dart';

part 'teacher.g.dart';

@Collection()
class Teacher {
  Teacher(
      {required this.name,
      required this.refferenceNumber,
      required this.department,
      required this.gender});
  Id id = Isar.autoIncrement;
  late String name;
  late String refferenceNumber;
  late String department;
  late String gender;
  final course = IsarLink<Course>();
}
