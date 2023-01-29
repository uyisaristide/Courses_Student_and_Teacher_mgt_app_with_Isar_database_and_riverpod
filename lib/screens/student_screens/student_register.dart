import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/course.dart';
import 'package:isar_project/models/student.dart';

import '../../constants.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController genderCotroller = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  bool checkValue = false;

  List<Course> _listCourse = [];
  var isars = IsarServise();
  List<Course> selectedCourses = [];
  getList() async {
    var _listCourses = await isars.getAllCourses();
    setState(() {
      _listCourse = _listCourses;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            ' STUDENT',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'register student',
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
                            controller: regNumberController,
                            validator: (value) =>
                                Validators.validateName(value!),
                            hintText: 'Registration number',
                            label: 'Registration number',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: genderCotroller,
                            validator: (value) =>
                                Validators.validateNumber(value!),
                            hintText: 'Gender',
                            label: 'Gender',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          CustomTextField(
                            controller: departmentController,
                            validator: (value) =>
                                Validators.validateNumber(value!),
                            hintText: 'Department',
                            label: 'Department',
                            icon: Icons.person,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: _listCourse.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext context, int index) {
                                  return CheckboxListTile(
                                    title: Text(_listCourse[index].couseName),
                                    value: _listCourse[index].isSelected,
                                    selected: _listCourse[index].isSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        _listCourse[index].isSelected = value!;
                                        if (selectedCourses
                                            .contains(_listCourse[index])) {
                                          selectedCourses
                                              .remove(_listCourse[index]);
                                        } else {
                                          selectedCourses
                                              .add(_listCourse[index]);
                                        }
                                      });
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
                          label: 'Register',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selectedCourses.isEmpty) {
                                return ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: const SizedBox(
                                        height: 80,
                                        child: Center(
                                          child: Text(
                                            'You must select atleast one course!',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                      action: SnackBarAction(
                                        textColor: Colors.white,
                                        label: 'Ok',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      )),
                                );
                              } else {
                                final newStudent = Student(
                                    name: nameController.text,
                                    regNumber: regNumberController.text,
                                    department: departmentController.text,
                                    gender: genderCotroller.text);

                                newStudent.courses.addAll(selectedCourses);
                                IsarServise isar = IsarServise();

                                isar.saveStudent(newStudent);

                                context.push('/students');
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
