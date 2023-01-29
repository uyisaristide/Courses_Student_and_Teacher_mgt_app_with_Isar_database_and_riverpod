import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/screens/auth_screens/validators/validator.dart';

import '../../constants.dart';
import 'widgets/authentication_button.dart';
import 'widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  static String id = 'RegisterScreen';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.9,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Create a new account',
                              style: TextStyle(
                                color: kGreyColor,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 40.0),
                            CustomTextField(
                              validator: (value) =>
                                  Validators.validateName(value!),
                              hintText: 'Full Name',
                              label: 'Full Name',
                              icon: Icons.person,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              validator: (value) =>
                                  Validators.validateEmail(value!),
                              hintText: 'Email',
                              label: "Email",
                              icon: Icons.mail,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              validator: (value) =>
                                  Validators.validatePassword(value!),
                              hintText: 'Password',
                              label: 'Password',
                              icon: Icons.lock,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            CustomTextField(
                              validator: (value) =>
                                  Validators.validatePassword(value!),
                              hintText: 'Confirm Password',
                              label: 'Confim Password',
                              icon: Icons.lock,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 15.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account ?',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              kDarkGreenColor),
                                    ),
                                    onPressed: () {
                                      context.push('/login');
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: AuthenticationButton(
                            label: 'Sign Up',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) ;
                            },
                          ),
                        )
                      ],
                    ),
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
