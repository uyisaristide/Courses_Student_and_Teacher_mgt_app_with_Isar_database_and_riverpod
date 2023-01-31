import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/Providers/courses/notifiers/course_notifier.dart';
import 'package:isar_project/Providers/courses/notifiers/get_courses_for_a_student.dart';
import 'package:isar_project/models/course.dart';

var createCourseProvider = StateNotifierProvider<CourseNotifier, List<Course>>(
  (ref) => CourseNotifier(),
);
var getCourseFor = StateNotifierProvider<GetCoursesForNotifier, List<Course>>(
  (ref) => GetCoursesForNotifier(),
);
