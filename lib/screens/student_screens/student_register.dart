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
  String? id;
  StudentRegisterScreen({super.key, this.id});

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
  String genderItem = 'Male';

  List departmentItems = ['CSC', 'IT', 'IS', 'Science'];
  String departmentItem = 'IT';

  fillData() {
    var detailsState = ref.read(studentDetailProvider);
    var details = detailsState.data;
    if (widget.id != null) {
      nameController.text = details!.name;
      regNumberController.text = details.regNumber;
      genderItem = details.gender;
      departmentItem = details.department;

      ref.read(selectedCourseProvider.notifier).state =
          details.courses.toList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createCourseProvider.notifier).getAllCourses();

      if (widget.id != null) {
        ref
            .read(studentDetailProvider.notifier)
            .getStudentDetails(int.parse('${widget.id}'));

        fillData();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listCourse = ref.watch(createCourseProvider);
    var selectedCourses = ref.watch(selectedCourseProvider);
    print('selected courses: ${selectedCourses.length}');
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
                            hint: 'Gender',
                            onChanged: (newValue) {
                              setState(() {
                                genderItem = newValue as String;
                              });
                            },
                          ),
                          CustomDropdown(
                            itemValue: departmentItem,
                            itemsList: departmentItems,
                            hint: 'Department',
                            onChanged: (newValue) {
                              setState(() {
                                departmentItem = newValue as String;
                              });
                            },
                          ),
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
                                        value: selectedCourses
                                                .where((element) =>
                                                    element.id ==
                                                    listCourse[index].id)
                                                .isNotEmpty
                                            ? true
                                            : false,
                                        selected: selectedCourses
                                            .where((element) =>
                                                element.id ==
                                                listCourse[index].id)
                                            .isNotEmpty,
                                        onChanged: (value) {
                                          if (selectedCourses
                                              .where((element) =>
                                                  element.id ==
                                                  listCourse[index].id)
                                              .isNotEmpty) {
                                            var rem = selectedCourses
                                                .where((element) =>
                                                    element.id !=
                                                    listCourse[index].id)
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
                          label: widget.id == null
                              ? 'createStudent.register'.tr()
                              : 'Update',
                          onPressed: () async {
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
                                        onPressed: () {},
                                      )),
                                );
                              } else {
                                final newStudent = Student(
                                    name: nameController.text,
                                    regNumber: regNumberController.text,
                                    department: departmentItem,
                                    gender: genderItem);

                                newStudent.courses.addAll(selectedCourses);

                                if (widget.id == null) {
                                  ref
                                      .read(studentProvider.notifier)
                                      .saveStudent(newStudent);
                                } else {
                                  ref
                                      .read(studentProvider.notifier)
                                      .updateStudent(int.parse('${widget.id}'),
                                          newStudent,newStudent.courses);
                                }

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
