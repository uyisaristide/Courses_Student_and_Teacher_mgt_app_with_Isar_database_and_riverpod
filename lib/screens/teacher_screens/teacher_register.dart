import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';
import 'package:isar_project/Providers/teachers/providers.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';
import '../common/dropdown.dart';

class TeacherRegisterScreen extends ConsumerStatefulWidget {
  const TeacherRegisterScreen({super.key});

  @override
  ConsumerState<TeacherRegisterScreen> createState() =>
      _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends ConsumerState<TeacherRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController refferenceNumberController =
      TextEditingController();
  final TextEditingController genderCotroller = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final teacherState = StateProvider<Course?>((ref) => null);
  @override
  void initState() {
    ref.read(createCourseProvider.notifier).getAllCourses();
    super.initState();
  }

  List genderItems = ['Male', 'Female'];
  String genderItem = 'Male';

  List departmentItems = ['CSC', 'IT', 'IS', 'Science'];
  String departmentItem = 'IT';

  @override
  Widget build(BuildContext context) {
    var listCourse = ref.watch(createCourseProvider);
    var selectedCourse = ref.watch(teacherState);
    return Material(
      child: Stack(
        children: [
          Scaffold(
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ' TEACHER',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'register teacher',
                            style: TextStyle(
                              color: kGreyColor,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          CustomTextField(
                            controller: nameController,
                            validator: (value) =>
                                Validators.validateName(value!),
                            hintText: 'Full Name',
                            label: 'Full Name',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: refferenceNumberController,
                            validator: (value) =>
                                Validators.validateName(value!),
                            hintText: 'Refference number',
                            label: 'Refference number',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomDropdown(
                              itemValue: genderItem,
                              itemsList: genderItems,
                              hint: 'Gender'),
                          CustomDropdown(
                              itemValue: departmentItem,
                              itemsList: departmentItems,
                              hint: 'Department'),
                          SizedBox(
                            height: 200,
                            child: listCourse.isEmpty
                                ? Row(
                                    children: [
                                      const Flexible(
                                        child: Text(
                                            "There must be a course before adding a Teacher"),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            context.go('/addCourse');
                                          },
                                          child: const Text('Add Course'))
                                    ],
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: listCourse.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return RadioListTile(
                                        activeColor: kDarkGreenColor,
                                        value: listCourse[index],
                                        groupValue: selectedCourse,
                                        onChanged: (currentCourse) {
                                          ref
                                              .read(teacherState.notifier)
                                              .state = listCourse[index];
                                        },
                                        title:
                                            Text(listCourse[index].couseName),
                                        selected: false,
                                      );
                                    }),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: AuthenticationButton(
                          label: 'Register',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedCourse == null) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: const SizedBox(
                                        height: 80,
                                        child: Center(
                                          child: Text(
                                            'Teacher must Have a Course!',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: 'Right?',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      )),
                                );
                              } else {
                                final newTeacher = Teacher(
                                    name: nameController.text,
                                    refferenceNumber:
                                        refferenceNumberController.text,
                                    department: departmentItem,
                                    gender: genderItem);
                                newTeacher.course.value = selectedCourse;

                                ref
                                    .read(teacherProvider.notifier)
                                    .saveTeacher(newTeacher);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    height: 80,
                                    child: Center(
                                      child: Text(
                                        'Saved successfully',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: kDarkGreenColor),
                                      ),
                                    ),
                                  ),
                                ));

                                context.pop();
                              }
                            }
                          },
                        ),
                      )
                    ],
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
