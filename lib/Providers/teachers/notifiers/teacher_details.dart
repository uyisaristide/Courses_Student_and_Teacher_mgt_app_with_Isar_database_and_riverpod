
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_project/Providers/core/response_info.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/teacher.dart';


class TeacherDetailsNotifier extends StateNotifier<ResponseInfo<Teacher>> {
  TeacherDetailsNotifier() : super((ResponseInfo()));

  Future<ResponseInfo<Teacher>> getTeacherDetails(int id) async {
    state.data = isarDb.teachers.getSync(id);
    return state;
  }
}
