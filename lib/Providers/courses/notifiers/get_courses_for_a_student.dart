import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/course.dart';

import '../../../models/student.dart';

class GetCoursesForNotifier extends StateNotifier<List<Course>> {
  GetCoursesForNotifier() : super([]);

  Future<List<Course>> getCourseFor(Student student) async {
    state =await isarDb.courses
        .filter()
        .students((q) => q.idEqualTo(student.id))
        .findAll();

    return state;
  }
}
