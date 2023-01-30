import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/models/course.dart';

class SelectedCourseNotifier extends StateNotifier<ResponseInfo<Course>> {
  SelectedCourseNotifier() : super(ResponseInfo());

  void selectCourse(Course) {
    state.data = Course;
    
  }
}
