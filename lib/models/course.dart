import 'package:isar/isar.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';

part 'course.g.dart';

@Collection()
class Course {
  Course({required this.couseName,required this.credits});
  Id id = Isar.autoIncrement;
  late String couseName;
  late int credits;

  bool isSelected = false;

  @Backlink(to: "course")
  final teacher = IsarLink<Teacher>();

  @Backlink(to: "courses")
  final students = IsarLinks<Student>();

  
  }

  

