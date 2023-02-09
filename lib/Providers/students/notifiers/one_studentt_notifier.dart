import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/database/isar.dart';

import '../../../models/student.dart';

class StudentDetailsNotifier extends StateNotifier<ResponseInfo<Student>> {
  StudentDetailsNotifier() : super((ResponseInfo()));

  Future<ResponseInfo<Student>> getStudentDetails(int id) async {
    state.data = isarDb.students.getSync(id);
    return state;
  }

  // updateStudent(int id, Student studentUpdate) async {
  //   await isarDb.writeTxn(() async {
  //     var student = await isarDb.students.get(id);
  //     // student = studentUpdate;
  //     student!.name = studentUpdate.name;
  //     student.courses = studentUpdate.courses;
  //     student.department = studentUpdate.department;
  //     student.gender = studentUpdate.gender;
  //     student.regNumber = studentUpdate.regNumber;

  //     await isarDb.students.put(student);
  //   });
  //   return state;
  // }
}
