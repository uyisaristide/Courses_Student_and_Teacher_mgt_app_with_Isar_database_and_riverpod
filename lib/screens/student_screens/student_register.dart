import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/screens/common/dropdown.dart';

import '../../constants.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';

class StudentRegisterScreen extends ConsumerStatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  ConsumerState<StudentRegisterScreen> createState() =>
      _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends ConsumerState<StudentRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController genderCotroller = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  var selectedCourseProvider = StateProvider<List<Course>>((ref) => []);

  List genderItems = ['Male', 'Female'];
   String genderItem ='Male';

  List departmentItems = ['CSC', 'IT', 'IS', 'Science'];
   String departmentItem = 'IT';

  @override
  void initState() {
    ref.read(createCourseProvider.notifier).getAllCourses();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listCourse = ref.watch(createCourseProvider);
    var selectedCourses = ref.watch(selectedCourseProvider);
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
                            'createStudent.title',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ).tr(),
                          const SizedBox(height: 10.0),
                          Text(
                            'createStudent.subtitle',
                            style: TextStyle(
                              color: kGreyColor,
                              fontSize: 16.0,
                            ),
                          ).tr(),
                          const SizedBox(height: 40.0),
                          CustomTextField(
                            controller: nameController,
                            validator: (value) =>
                                Validators.validateName(value!),
                            hintText: 'createStudent.form.name'.tr(),
                            label: 'createStudent.form.name'.tr(),
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: regNumberController,
                            validator: (value) =>
                                Validators.validateName(value!),
                            hintText: 'createStudent.form.regNo'.tr(),
                            label: 'createStudent.form.regNo'.tr(),
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
                          // CustomTextField(
                          //   controller: departmentController,
                          //   validator: (value) =>
                          //       Validators.validateNumber(value!),
                          //   hintText: 'createStudent.form.department'.tr(),
                          //   label: 'createStudent.form.department'.tr(),
                          //   icon: Icons.person,
                          //   keyboardType: TextInputType.name,
                          //   onChanged: (value) {},
                          // ),
                          SizedBox(
                            height: 200,
                            child: listCourse.isEmpty
                                ? Row(
                                    children: [
                                      const Text(
                                          "There must be a course before adding a student"),
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
                                    shrinkWrap: false,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CheckboxListTile(
                                        title:
                                            Text(listCourse[index].couseName),
                                        value: listCourse[index].isSelected,
                                        selected: listCourse[index].isSelected,
                                        onChanged: (value) {
                                          listCourse[index].isSelected = value!;
                                          if (selectedCourses
                                              .contains(listCourse[index])) {
                                            var rem = selectedCourses
                                                .where((element) =>
                                                    element !=
                                                    listCourse[index])
                                                .toList();
                                            ref
                                                .read(selectedCourseProvider
                                                    .notifier)
                                                .state = rem;
                                          } else {
                                            ref
                                                .read(selectedCourseProvider
                                                    .notifier)
                                                .state = [
                                              ...ref.watch(
                                                  selectedCourseProvider),
                                              listCourse[index]
                                            ];
                                          }
                                        },
                                        activeColor: kDarkGreenColor,
                                        checkColor: Colors.white,
                                        secondary: const Icon(Icons.book),
                                      );
                                    }),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: AuthenticationButton(
                          label: 'createStudent.register'.tr(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedCourses.isEmpty) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: SizedBox(
                                        height: 80,
                                        child: Center(
                                          child: const Text(
                                            'createStudent.snackbar.text',
                                            style: TextStyle(fontSize: 24),
                                          ).tr(),
                                        ),
                                      ),
                                      action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: 'createStudent.snackbar.ok'.tr(),
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      )),
                                );
                              } else {
                                
                                  final newStudent = Student(
                                      name: nameController.text,
                                      regNumber: regNumberController.text,
                                      department: departmentItem ,
                                      gender: genderItem );

                                  newStudent.courses.addAll(selectedCourses);

                                  ref
                                      .read(studentProvider.notifier)
                                      .saveStudent(newStudent);
                              
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
        ],
      ),
    );
  }
}
