import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/student.dart';

import '../../../models/course.dart';

class StudentNotifier extends StateNotifier<List<Student>> {
  StudentNotifier() : super([]);

  Future<void> saveStudent(Student newStudent) async {
    await isarDb.writeTxn(() async {
      await isarDb.students.put(newStudent);
      await newStudent.courses.save();
    });
  }

  getAllStudents() async {
    state = await isarDb.students.where().findAll();

    var usersStream = isarDb.students.where().watch();

    usersStream.listen((event) {
      state = event;
    });
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

  updateStudent(int id, Student studentUpdate, courses) async {
    await isarDb.writeTxn(() async {
      studentUpdate.id = id;
      studentUpdate.courses = courses;
      print("Courses for ${studentUpdate.name}: ");
      print(studentUpdate.courses.map((e) => e.couseName));
      //  studentUpdate.courses.clear();
      
      await isarDb.students.put(studentUpdate);
      studentUpdate.courses.save();
      await studentUpdate.courses.reset();

      // isarDb.writeTxn(() => studentUpdate.courses.reset());
    });

    return state;
  }
}
