import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/teachers/providers.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';
import 'package:isar_project/screens/student_screens/student_details.dart';
import 'package:isar_project/screens/teacher_screens/teacher_details_screen.dart';

import '../../constants.dart';

class TeachersScreen extends ConsumerStatefulWidget {
  const TeachersScreen({super.key});

  @override
  ConsumerState<TeachersScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<TeachersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    ref.read(teacherProvider.notifier).getAllTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listTeachers = ref.watch(teacherProvider);
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ' Teachers ',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 400,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: listTeachers.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        context.push('/teacherDetails',
                                            extra: listTeachers[index]
                                            // '/teacherDetails/?id=${listTeachers[index].id}',
                                            );
                                        print(listTeachers[index].name);
                                      },
                                      focusColor: kFoamColor,
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          listTeachers[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundColor: kDarkGreenColor,
                                          child: Text('${index + 1}')),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 15.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'To add new Teacher click',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(kFoamColor),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              kDarkGreenColor),
                                    ),
                                    onPressed: () {
                                      context.push('/addTeacher');
                                    },
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: kDarkGreenColor,
                  size: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
