
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';
import 'package:path_provider/path_provider.dart';

import 'package:isar/isar.dart';

import '../models/teacher.dart';

late Isar isarDb;

Future<void> openDb() async {
    final dir = await getApplicationSupportDirectory();

    if (Isar.instanceNames.isEmpty) {
      isarDb =  await Isar.open([CourseSchema, StudentSchema, TeacherSchema],
          inspector: true, directory: dir.path);
    }
    // return Future.value(Isar.getInstance());
  }