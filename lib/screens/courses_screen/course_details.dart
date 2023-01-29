import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/contollers/isar_servise.dart';
import 'package:isar_project/models/student.dart';
import 'package:isar_project/models/teacher.dart';

import '../../constants.dart';
import '../../models/course.dart';

class CourseDetailsScreen extends StatefulWidget {
  Course course;
  CourseDetailsScreen({super.key, required this.course});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  List<Student> studentsList = [];
  // late Course course;
  var isars = IsarServise();
  Teacher? teacher;

  getSudentsList() async {
    var students = await isars.getStudentFor(widget.course);
    var myTeacher = await isars.getTeacherFor(widget.course);
    setState(() {
      studentsList = students;
      teacher = myTeacher;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSudentsList();
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
                ' Details of ${widget.course.couseName} course ',
                style: TextStyle(
                  // fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkGreenColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
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
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          ' About Course',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Course Name: ',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              widget.course.couseName,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Number of credits: ',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              '${widget.course.credits}',
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Teacher',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        teacher == null
                            ? const Text('Has not Teacher rightnow')
                            : ListTile(
                                onTap: () {},
                                focusColor: kFoamColor,
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Text(
                                    teacher!.name,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                leading: CircleAvatar(
                                    backgroundColor: kDarkGreenColor,
                                    child: const Icon(Icons.book)),
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          ' Subscribed Students',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 200,
                          child: studentsList.isEmpty
                              ? const Text(
                                  'No student unrolled for this course')
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: studentsList.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           CourseDetailsScreen(course: studentsList[index],)),
                                        // );
                                      },
                                      focusColor: kFoamColor,
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          studentsList[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
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