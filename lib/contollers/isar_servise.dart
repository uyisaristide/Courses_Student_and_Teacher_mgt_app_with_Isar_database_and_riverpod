import 'package:isar/isar.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';
import 'package:path_provider/path_provider.dart';

class IsarServise {
  late Future<Isar> db;
  IsarServise() {
    db = openDb();
  }

  //All about Create

  Future<void> saveCourse(Course newCourse) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.courses.putSync(newCourse));
  }

  Future<void> saveStudent(Student newStudent) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.students.putSync(newStudent));
  }

  Future<void> saveTeacher(Teacher newTeacher) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.teachers.putSync(newTeacher));
  }

  // All about Read All


  Future<List<Course>> getAllCourses() async {
    final isar = await db;
    return await isar.courses.where().findAll();
  }

  Future<List<Student>> getAllStusents() async {
    final isar = await db;
    return await isar.students.where().findAll();
  }

  Future<List<Teacher>> getAllTeachers() async {
    final isar = await db;
    return await isar.teachers.where().findAll();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<Student>> getStudentFor(Course course) async {
    final isar = await db;
    return isar.students
        .filter()
        .courses((q) => q.idEqualTo(course.id))
        .findAll();
  }

  Future<List<Course>> getCourseFor(Student student) async {
    final isar = await db;
    return isar.courses
        .filter()
        .students((q) => q.idEqualTo(student.id))
        .findAll();
  }
  Future<Course?> getTeacherCourse(Teacher teacher) async {
    final isar = await db;
    return isar.courses
        .filter()
        .teacher((q) => q.idEqualTo(teacher.id))
        .findFirst();
  }

  Future<Teacher?> getTeacherFor(Course course) async {
    final isar = await db;
    final teacher = isar.teachers
        .filter()
        .course((q) => q.idEqualTo(course.id))
        .findFirst();
    return teacher;
  }
   Future<Teacher?> getTeacherDetails(int id) async {
    final isar = await db;
    final teacher = isar.teachers.filter().idEqualTo(id).findFirst();
    return teacher;
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationSupportDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([CourseSchema, StudentSchema, TeacherSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
}
