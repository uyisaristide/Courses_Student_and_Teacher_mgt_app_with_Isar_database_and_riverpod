import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/teachers/providers.dart';

import '../../constants.dart';

class TeacherDetailsScreen extends ConsumerStatefulWidget {
  String id;
  TeacherDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<TeacherDetailsScreen> createState() =>
      _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends ConsumerState<TeacherDetailsScreen> {
  @override
  void initState() {
    ref
        .read(teacherDetailProvider.notifier)
        .getTeacherDetails(int.parse(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var teacher = ref.watch(teacherDetailProvider).data;
    var course = teacher!.course.value;
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade300,
              title: Text(
                ' Details of ${teacher.name} ',
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
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${teacher.id}',
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
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                teacher.name,
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
                                      course.couseName,
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
