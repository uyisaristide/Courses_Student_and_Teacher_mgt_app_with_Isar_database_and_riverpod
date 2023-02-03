import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/teacher.dart';

class TeacherNotifier extends StateNotifier<List<Teacher>> {
  TeacherNotifier() : super([]);

  Future<void> saveTeacher(Teacher newTeacher) async {
    // final isar = await db;
    // isarDb.writeTxnSync<int>(() => isarDb.teachers.putSync(newTeacher));
    await isarDb.writeTxn(() async {
      await isarDb.teachers.put(newTeacher);
    });
    state = [...state, newTeacher];
  }

  Future<List<Teacher>> getAllTeachers() async {
    state = await isarDb.teachers.where().findAll();
    return state;
  }
}
