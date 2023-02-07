import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/teachers/providers.dart';

import '../../constants.dart';

class TeachersScreen extends ConsumerStatefulWidget {
  const TeachersScreen({super.key});

  @override
  ConsumerState<TeachersScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<TeachersScreen> {
  @override
  void initState() {
    ref.read(teacherProvider.notifier).getAllTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listTeachers = ref.watch(teacherProvider);
    return Material(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                ' Teachers: ${listTeachers.length}',
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
                              ref.read(teacherProvider.notifier).state =
                                  listTeachers;
                            } else {
                              listTeachers = listTeachers
                                  .where((teacher) => teacher.name
                                      .toLowerCase()
                                      .contains(keyWord.toLowerCase()))
                                  .toList();
                              ref.read(teacherProvider.notifier).state =
                                  listTeachers;
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
                          SizedBox(
                            height: 400,
                            child: listTeachers.isEmpty
                                ? const Center(
                                    child: Text('there is no teacher'),
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: listTeachers.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          context.push(
                                              "/teacherDetails?id=${listTeachers[index].id}");
                                        },
                                        focusColor: kFoamColor,
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40),
                                          child: Text(
                                            listTeachers[index].name,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                            backgroundColor: kDarkGreenColor,
                                            child: Text('${index + 1}')),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
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
                                  'To add new Teacher click',
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
                                    context.push('/addTeacher');
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
