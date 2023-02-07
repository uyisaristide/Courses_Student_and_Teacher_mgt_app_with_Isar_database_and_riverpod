import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../../models/course.dart';

class CourseDetailsScreen extends ConsumerStatefulWidget {
  String id;
  CourseDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<CourseDetailsScreen> createState() =>
      _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends ConsumerState<CourseDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Teacher? teacher;

  @override
  void initState() {
    ref.read(createCourseProvider.notifier).getAllCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var course = ref.watch(createCourseProvider).where((element) => element.id == int.parse(widget.id)).first;
    var studentsList = course.students.toList();
    var teacher =course.teacher.value;
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Text(
                ' Details of ${course.couseName} course ',
                style: TextStyle(
                  // fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkGreenColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          ' About Course',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Course Name: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              course.couseName,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Number of credits: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${course.credits}',
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Teacher',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        teacher == null
                            ? const Text('Has not Teacher rightnow')
                            : ListTile(
                                onTap: () {},
                                focusColor: kFoamColor,
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    teacher.name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                leading: CircleAvatar(
                                    backgroundColor: kDarkGreenColor,
                                    child: const Icon(Icons.book)),
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          ' Subscribed Students',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 200,
                          child: studentsList.isEmpty
                              ? const Text(
                                  'No student unrolled for this course')
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: studentsList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           CourseDetailsScreen(course: studentsList[index],)),
                                        // );
                                      },
                                      focusColor: kFoamColor,
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          studentsList[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundColor: kDarkGreenColor,
                                          child: Text('${index + 1}')),
                                    );
                                  }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
