import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/database/isar.dart';

import '../../../models/student.dart';

class StudentDetailsNotifier extends StateNotifier<ResponseInfo<Student>> {
  StudentDetailsNotifier() : super((ResponseInfo()));

  getStudentDetails(int id) async {
    state.data = isarDb.students.getSync(id);
    var details = isarDb.students.watchObject(id);

    details.listen((event) {
      state.data = event;
    });
  }
}
