import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/course.dart';

class CourseNotifier extends StateNotifier<List<Course>> {
  CourseNotifier() : super([]);

  Future<void> saveCourse(Course newCourse) async {
    // final isar = await db;
    // isarDb.writeTxnSync<int>(() => isarDb.courses.putSync(newCourse));

    await isarDb.writeTxn(() async {
      await isarDb.courses.put(newCourse);
    });

    state = [...state, newCourse];
  }

  Future<List<Course>> getAllCourses() async {
    state = await isarDb.courses.where().findAll();
    return state;
  }
}
