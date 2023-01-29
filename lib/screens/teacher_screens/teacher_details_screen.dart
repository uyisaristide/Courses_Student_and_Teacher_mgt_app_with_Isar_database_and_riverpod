import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../../models/course.dart';

class TeacherDetailsScreen extends StatefulWidget {
  Teacher teacher;
  TeacherDetailsScreen({super.key, required this.teacher});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  // List<Teacher> coursesList = [];
  Course? course;
  // late Course course;
  var isars = IsarServise();

  getCoursesFor() async {
    var courses = await isars.getTeacherCourse(widget.teacher);
    setState(() {
      course = courses;
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
    getCoursesFor();
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Text(
                ' Details of ${widget.teacher.name} ',
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
                            ' About Teacher',
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
                                'Teacher Id: ',
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                '${widget.teacher.id}',
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
                                widget.teacher.name,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Teacher Of',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w600,
                              color: kDarkGreenColor,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          course == null
                              ? const Text('')
                              : ListTile(
                                  onTap: () {},
                                  focusColor: kFoamColor,
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: Text(
                                      course!.couseName,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                      backgroundColor: kDarkGreenColor,
                                      child: const Icon(Icons.book)),
                                )
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
