import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/screens/home_screen/widgets/entity_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        foregroundColor: Colors.black45,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 150,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  'Welcome Here',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
            EntityButtons(
              buttonColor: const Color(0Xff4267B2),
              mediaIcon: Icons.person_search_outlined,
              media: 'Student',
              onPressed: () {
                context.push('/students');
              },
            ),
            EntityButtons(
              buttonColor: const Color(0Xff1DA1F2),
              mediaIcon: Icons.book,
              media: 'Course',
              onPressed: () {
                context.push('/courses');
              },
            ),
            EntityButtons(
              buttonColor: const Color(0XfFEA4335),
              mediaIcon: Icons.chair,
              media: 'Teacher',
              onPressed: () {
                context.push('/teachers');
              },
            ),
          ],
        ),
      ),
    );
  }
}
