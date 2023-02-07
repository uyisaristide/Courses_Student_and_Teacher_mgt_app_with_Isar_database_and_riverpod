
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/course.dart';


class CourseDetailsNotifier extends StateNotifier<ResponseInfo<Course>> {
  CourseDetailsNotifier() : super((ResponseInfo()));

  Future<ResponseInfo<Course>> getCoursesDetails(int id) async {
    state.data = isarDb.courses.getSync(id);
    return state;
  }
}
