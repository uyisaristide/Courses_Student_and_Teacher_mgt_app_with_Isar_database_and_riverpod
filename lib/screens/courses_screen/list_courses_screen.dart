import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/courses/providers.dart';

import '../../constants.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  @override
  void initState() {
    ref.read(createCourseProvider.notifier).getAllCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listCourse = ref.watch(createCourseProvider);

    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                ' Courses: ${listCourse.length}',
                style: TextStyle(
                  fontSize: 32.0,
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
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          onChanged: (keyWord) {
                            if (keyWord.isEmpty) {
                              ref.read(createCourseProvider.notifier).state =
                                  listCourse;
                            } else {
                              listCourse = listCourse
                                  .where((course) => course.couseName
                                      .toLowerCase()
                                      .contains(keyWord.toLowerCase()))
                                  .toList();
                              ref.read(createCourseProvider.notifier).state =
                                  listCourse;
                            }
                          },
                          decoration: const InputDecoration(
                              labelText: 'Search',
                              suffixIcon: Icon(Icons.search)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          listCourse.isEmpty
                              ? const Text('No course been added')
                              : SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: listCourse.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          onTap: () {
                                            context.push(
                                                "/courseDetails?id=${listCourse[index].id}");
                                          },
                                          focusColor: kFoamColor,
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Text(
                                              listCourse[index].couseName,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: kDarkGreenColor,
                                              ),
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                              backgroundColor: kDarkGreenColor,
                                              child: Text('${index + 1}')),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios),
                                        );
                                      }),
                                ),
                          const SizedBox(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'If you want to add new Coure click',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kFoamColor),
                                    foregroundColor: MaterialStateProperty.all(
                                        kDarkGreenColor),
                                  ),
                                  onPressed: () {
                                    context.push('/add');
                                  },
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
