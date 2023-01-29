import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../../models/course.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';

class TeacherRegisterScreen extends StatefulWidget {
  TeacherRegisterScreen({super.key});

  @override
  State<TeacherRegisterScreen> createState() => _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends State<TeacherRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController refferenceNumberController =
      TextEditingController();
  final TextEditingController genderCotroller = TextEditingController();
  final TextEditingController departmentController = TextEditingController();

  List<Course> _listCourse = [];
  Course? selectedCourse;
  var isars = IsarServise();

  getList() async {
    var _listCourses = await isars.getAllCourses();
    setState(() {
      _listCourse = _listCourses;
    });
  }

  getSelectedCourse(Course course) {
    setState(() {
      course = course;
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
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  // selectedCourse = _listCourse[index];
                                  return RadioListTile(
                                    activeColor: kDarkGreenColor,
                                    value: _listCourse[index],
                                    groupValue: selectedCourse,
                                    onChanged: (currentCourse) {
                                      setState(() {
                                        selectedCourse = _listCourse[index];
                                      });
                                    },
                                    title: Text(_listCourse[index].couseName),
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
                                    department: departmentController.text,
                                    gender: genderCotroller.text);
                                newTeacher.course.value = selectedCourse;
                                IsarServise isar = IsarServise();
                                isar.saveTeacher(newTeacher);

                                context.push('/teachers');
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
