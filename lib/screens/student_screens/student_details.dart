import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/models/teacher.dart';
import 'package:isar_project/screens/student_screens/students_list_screen.dart';
import 'package:isar_project/screens/teacher_screens/teachers_list.dart';

import '../../constants.dart';

class StudentDetailsScreen extends ConsumerStatefulWidget {
  String id;
  StudentDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<StudentDetailsScreen> createState() =>
      _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends ConsumerState<StudentDetailsScreen> {
  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        context.push("/updateStudent?id=${widget.id}");
        break;
      case 1:
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Delete Student"),
                content: const Text(
                    "Delete this Student, this action will not be undone"),
                actions: [
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        var response = ref
                            .read(studentProvider.notifier)
                            .deleteStudent(int.parse(widget.id));
                        if (response == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: const Text(
                                      'Deleted successfully',
                                      style: TextStyle(fontSize: 24),
                                    ).tr(),
                                  ),
                                ),
                                action: SnackBarAction(
                                  textColor: Colors.white,
                                  label: 'ok'.tr(),
                                  onPressed: () {},
                                )),
                          );
                        }

                        context.go('/students');
                      },
                      child: const Text("Delete")),
                ],
              );
            });
        break;
    }
  }

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
    var student = ref.watch(studentDetailProvider).data;
    var coursesList = student!.courses.toList();
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'studentDetails.title',
            style: TextStyle(
              // fontSize: 32.0,
              fontWeight: FontWeight.w600,
              color: kDarkGreenColor,
            ),
          ).tr(namedArgs: {'student': student.name}),
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                  textTheme:
                      const TextTheme().apply(bodyColor: kDarkGreenColor),
                  iconTheme: IconThemeData(color: kDarkGreenColor)),
              child: PopupMenuButton<int>(
                color: Colors.black,
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.system_update_alt),
                          ),
                          Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      )),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.delete),
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      )),
                ],
                onSelected: (item) => SelectedItem(context, item),
              ),
            ),
          ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gender : ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ).tr(),
                          Text(
                            student.gender,
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
                                itemBuilder: (BuildContext context, int index) {
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
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    subtitle: teacher == null
                                        ? const Text('Has no Teacher')
                                        : const Text('studentDetails.teacher')
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
    );
  }
}
