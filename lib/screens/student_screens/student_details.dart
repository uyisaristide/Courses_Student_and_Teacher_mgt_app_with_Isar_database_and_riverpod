import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../../models/course.dart';
import '../auth_screens/validators/validator.dart';
import '../auth_screens/widgets/authentication_button.dart';
import '../auth_screens/widgets/custom_text_field.dart';

class StudentDetailsScreen extends StatefulWidget {
  Student student;
  StudentDetailsScreen({super.key, required this.student});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  List<Course> coursesList = [];
  // late Course course;
  var isars = IsarServise();

  getCoursesFor() async {
    var courses = await isars.getCourseFor(widget.student);
    setState(() {
      // courses.forEach((element) {
      //   element.teacher.loadSync();
      // });
      coursesList = courses;
    });
  }

  Teacher? teacher;
  getTecherOfCourse(Course course) async {
    var myTeacher = await isars.getTeacherFor(course);
    setState(() {
      teacher = myTeacher;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCoursesFor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Text(
                ' Details of ${widget.student.name} ',
                style: TextStyle(
                  // fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkGreenColor,
                ),
              ),
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
                            ' About Student',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Reg number: ',
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                widget.student.regNumber,
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
                                'Name: ',
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                widget.student.name,
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
                                'Department : ',
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                widget.student.department,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            ' Courses Subscribed',
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
                                      // getTecherOfCourse(coursesList[index]);
                                      return ListTile(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           StudentDetailsScreen(course: studentsList[index],)),
                                          // );
                                        },
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
                                            : Text(
                                                'By Teacher ${teacher.name}'),
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
          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
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
