import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/database/isar.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';
import 'package:isar_project/screens/auth_screens/login.dart';
import 'package:isar_project/screens/auth_screens/register.dart';
import 'package:isar_project/screens/courses_screen/course_details.dart';

import 'package:isar_project/screens/home_screen/home_screen.dart';
import 'package:isar_project/screens/settings/translations.dart';

import 'package:isar_project/screens/student_screens/student_register.dart';
import 'package:isar_project/screens/teacher_screens/teacher_details_screen.dart';
import 'package:isar_project/screens/teacher_screens/teacher_register.dart';
import 'package:isar_project/screens/teacher_screens/teachers_list.dart';

import 'screens/courses_screen/course_register.dart';
import 'screens/courses_screen/list_courses_screen.dart';
import 'screens/student_screens/student_details.dart';
import 'screens/student_screens/students_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await openDb();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
        Locale('rw', 'RW')
      ],
      assetLoader: const RootBundleAssetLoader(),
      startLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      path: 'assets/translations',
      child: const ProviderScope(child: MyApp())));
}

final _router = GoRouter(
  initialLocation: '/languages',
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
        // Student student = state.extra as Student;
        var id = state.queryParams['id'];
        return StudentDetailsScreen(
          id: "$id",
        );
      },
    ),
    GoRoute(
      path: '/students',
      builder: (context, state) => const StudentsScreen(),
    ),

    GoRoute(
      path: '/languages',
      builder: (context, state) => const LanguageChange(),
    ),

    //Courses routes
    GoRoute(
      path: '/add',
      builder: (context, state) => CourseRegisterScreen(),
    ),
    GoRoute(
      path: '/courses',
      builder: (context, state) => const CoursesScreen(),
    ),
    GoRoute(
      path: '/courseDetails',
      builder: (context, state) {
        // Student student = state.extra as Student;
        var id = state.queryParams['id'];
        return CourseDetailsScreen(
          id: "$id",
        );
      },
    ),

    GoRoute(
      path: '/addTeacher',
      builder: (context, state) => const TeacherRegisterScreen(),
    ),
    GoRoute(
      path: '/teachers',
      builder: (context, state) => const TeachersScreen(),
    ),
    GoRoute(
      path: '/teacherDetails',
      builder: (context, state) {
        // Student student = state.extra as Student;
        var id = state.queryParams['id'];
        return TeacherDetailsScreen(
          id: "$id",
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
