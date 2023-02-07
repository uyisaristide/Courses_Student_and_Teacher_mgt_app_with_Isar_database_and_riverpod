import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/Providers/courses/notifiers/course_notifier.dart';
import 'package:isar_project/Providers/students/notifiers/one_studentt_notifier.dart';
import 'package:isar_project/Providers/students/notifiers/students_notifier.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';

var studentProvider = StateNotifierProvider<StudentNotifier, List<Student>>(
  (ref) => StudentNotifier(),
);
var studentDetailProvider = StateNotifierProvider<StudentDetailsNotifier,ResponseInfo<Student>>(
  (ref) => StudentDetailsNotifier(),
);
