import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/Providers/students/providers.dart';
import 'package:isar_project/models/student.dart';

import '../../constants.dart';

class StudentsScreen extends ConsumerStatefulWidget {
  const StudentsScreen({super.key});

  @override
  ConsumerState<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends ConsumerState<StudentsScreen> {
  var foundStudentsProvider = StateProvider<List<Student>>((ref) => []);

  @override
  void initState() {
    ref.read(studentProvider.notifier).getAllStudents();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var foundStudents = ref.watch(studentProvider);
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'studentsScreen.title',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
              color: kDarkGreenColor,
            ),
          ).tr(),
          actions: [
            Text(
              '${foundStudents.length}',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: kDarkGreenColor,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (keyWord) {
                        if (keyWord.isEmpty) {
                          ref.read(studentProvider.notifier).state =
                              foundStudents;
                        } else {
                          foundStudents = foundStudents
                              .where((student) => student.name
                                  .toLowerCase()
                                  .contains(keyWord.toLowerCase()))
                              .toList();
                          ref.read(studentProvider.notifier).state =
                              foundStudents;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'Search', suffixIcon: Icon(Icons.search)),
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
                        child: foundStudents.isEmpty
                            ? const Center(
                                child: Text('there is no Student'),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: foundStudents.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Slidable(
                                    child: ListTile(
                                      onTap: () {
                                        context.push(
                                            "/studentDetails?id=${foundStudents[index].id}");
                                      },
                                      focusColor: kFoamColor,
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: Text(
                                          foundStudents[index].name,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundColor: kDarkGreenColor,
                                          child: Text('${index + 1}')),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  );
                                }),
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: const Text(
                                'studentsScreen.addNew',
                                style: TextStyle(fontSize: 18.0),
                              ).tr(),
                            ),
                            Flexible(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kFoamColor),
                                  foregroundColor: MaterialStateProperty.all(
                                      kDarkGreenColor),
                                ),
                                onPressed: () {
                                  context.push('/addStudent');
                                },
                                child: const Text(
                                  'studentsScreen.add',
                                  style: TextStyle(fontSize: 20.0),
                                ).tr(),
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
    );
  }
}
