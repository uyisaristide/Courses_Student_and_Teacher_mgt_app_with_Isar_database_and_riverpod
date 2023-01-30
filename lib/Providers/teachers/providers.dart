import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/courses/notifiers/course_notifier.dart';
import 'package:isar_project/Providers/teachers/notifiers/teacher_notifier.dart';
import 'package:isar_project/models/teacher.dart';

var teacherProvider = StateNotifierProvider<TeacherNotifier, List<Teacher>>(
  (ref) => TeacherNotifier(),
);
