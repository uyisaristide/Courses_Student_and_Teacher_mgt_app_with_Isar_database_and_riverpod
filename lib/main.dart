import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';
import 'package:isar_project/screens/auth_screens/login.dart';
import 'package:isar_project/screens/auth_screens/register.dart';
import 'package:isar_project/screens/courses_screen/course_details.dart';

import 'package:isar_project/screens/home_screen/home_screen.dart';

import 'package:isar_project/screens/student_screens/student_register.dart';
import 'package:isar_project/screens/teacher_screens/teacher_details_screen.dart';
import 'package:isar_project/screens/teacher_screens/teacher_register.dart';
import 'package:isar_project/screens/teacher_screens/teachers_list.dart';

import 'screens/courses_screen/course_register.dart';
import 'screens/courses_screen/list_courses_screen.dart';
import 'screens/student_screens/student_details.dart';
import 'screens/student_screens/students_list_screen.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  initialLocation: '/register',
  routes: [
    // Auth routes
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      // Home route
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Students

    GoRoute(
      path: '/addStudent',
      builder: (context, state) => const StudentRegisterScreen(),
    ),
    GoRoute(
      path: '/studentDetails',
      builder: (context, state) {
        Student student = state.extra as Student;

        return StudentDetailsScreen(
          student: student,
        );
      },
    ),
    GoRoute(
      path: '/students',
      builder: (context, state) => const StudentsScreen(),
    ),

    //Courses routes
    GoRoute(
      path: '/add',
      builder: (context, state) => CourseRegisterScreen(),
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => CoursesScreen(),
    ),
    GoRoute(
      path: '/courseDetails',
      builder: (context, state) {
        Course course = state.extra as Course;

        return CourseDetailsScreen(
          course: course,
        );
      },
    ),
    // GoRoute(

    //   path: "/teacherDetails",
    //   builder: (context, state) {
    //     int id = int.parse("${state.queryParams["id"]}");
    //     return TeacherDetailsScreen(teacher: id);
    //   },
    // ),

    //Teacher routes

    GoRoute(
      path: '/addTeacher',
      builder: (context, state) => TeacherRegisterScreen(),
    ),
    GoRoute(
      path: '/teachers',
      builder: (context, state) => const TeachersScreen(),
    ),

    GoRoute(
      path: '/teacherDetails',
      builder: (context, state) {
        Teacher teacher = state.extra as Teacher;

        return TeacherDetailsScreen(
          teacher: teacher,
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
