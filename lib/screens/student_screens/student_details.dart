import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';

class StudentDetailsScreen extends ConsumerStatefulWidget {
  String id;
  StudentDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<StudentDetailsScreen> createState() =>
      _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends ConsumerState<StudentDetailsScreen> {
  @override
  void initState() {
    // ref.read(studentProvider.notifier).getAllStudents();
    ref
        .read(studentDetailProvider.notifier)
        .getStudentDetails(int.parse(widget.id));
        
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var student = ref
    //     .watch(studentProvider)
    //     .where((element) => element.id == int.parse(widget.id))
    //     .first;
    var student = ref.watch(studentDetailProvider).data;
    var coursesList = student!.courses.toList();
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Text(
                'studentDetails.title',
                style: TextStyle(
                  // fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkGreenColor,
                ),
              ).tr(namedArgs: {'student': student.name}),
            ),
            body: SafeArea(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'studentDetails.about',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ).tr(),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'studentDetails.reg',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).tr(),
                              Text(
                                student.regNumber,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'studentDetails.name',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).tr(),
                              Text(
                                student.name,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'studentDetails.department',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).tr(),
                              Text(
                                student.department,
                                style: const TextStyle(fontSize: 25),
                              ).tr(),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'studentDetails.course',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ).tr(),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 300,
                            child: coursesList.isEmpty
                                ? const Text('No course been subscribed yet')
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: coursesList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Teacher? teacher =
                                          coursesList[index].teacher.value;

                                      return ListTile(
                                        onTap: () {},
                                        focusColor: kFoamColor,
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Text(
                                            coursesList[index].couseName,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        subtitle: teacher == null
                                            ? const Text('Has no Teacher')
                                            : const Text(
                                                    'studentDetails.teacher')
                                                .tr(namedArgs: {
                                                "teacher": teacher.name
                                              }),
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
          ),
          // Positioned(
          //   top: 30.0,
          //   left: 20.0,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.grey.shade300,
          //     radius: 20.0,
          //     child: IconButton(
          //       onPressed: () {
          //         // Navigator.pop(context);
          //         context.pop();
          //       },
          //       icon: Icon(
          //         Icons.arrow_back_ios_new,
          //         color: kDarkGreenColor,
          //         size: 24.0,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
