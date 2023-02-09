import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/student.dart';

import '../../../models/course.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]);

  Future<void> saveStudent(Student newStudent) async {
    // await isarDb.writeTxn(() async {
    //   await isarDb.students.put(newStudent);
    // });
    isarDb.writeTxnSync<int>(() => isarDb.students.putSync(newStudent));
    state = [...state, newStudent];
  }

  Future<List<Student>> getAllStudents() async {
    state = await isarDb.students.where().findAll();
    return state;
  }

  Future<List<Student>> getStudentFor(Course course) async {
    state = await isarDb.students
        .filter()
        .courses((q) => q.idEqualTo(course.id))
        .findAll();

    return state;
  }

  deleteStudent(int id) async {
    await isarDb.writeTxn(() async {
      await isarDb.students.delete(id);
    });
  }

   updateStudent(int id, Student studentUpdate) async {
    await isarDb.writeTxn(() async {
      var student = await isarDb.students.get(id);
      // student = studentUpdate;
      student!.name = studentUpdate.name;
      student.courses = studentUpdate.courses;
      student.department = studentUpdate.department;
      student.gender = studentUpdate.gender;
      student.regNumber = studentUpdate.regNumber;

      await isarDb.students.put(student);
    });
    return state;
  }
  
}
