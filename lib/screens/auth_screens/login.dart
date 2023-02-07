// // ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar_project/screens/auth_screens/validators/validator.dart';
import 'package:isar_project/screens/auth_screens/widgets/authentication_button.dart';

import '../../constants.dart';
import 'widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  String username = '';
  String password = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.67,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        height: 70,
                        child: Text(
                          'signIn.title',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600,
                            color: kDarkGreenColor,
                          ),
                        ).tr(),
                      ),
                      Text(
                        'signIn.subtitle',
                        style: TextStyle(
                          color: kGreyColor,
                          fontSize: 15.0,
                        ),
                      ).tr()
                    ],
                  ),

                  
                  Column(
                    children: [
                      CustomTextField(
                        validator: (value) => Validators.validateName(value!),
                        hintText: 'signIn.form.name'.tr(),
                        label: 'signIn.form.name'.tr(),
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          username = value != '' ? value : '';
                        },
                      ),
                      CustomTextField(
                        validator: (value) =>
                            Validators.validatePassword(value!),
                        hintText: 'signIn.form.password'.tr(),
                        label: 'signIn.form.password'.tr(),
                        icon: Icons.lock,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          password = value != '' ? value : '';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all(
                                      kDarkGreenColor),
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                ),
                                Text(
                                  'signIn.remember',
                                  style: TextStyle(
                                    color: kGreyColor,
                                    fontSize: 14.0,
                                  ),
                                ).tr()
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(kDarkGreenColor),
                              ),
                              child: const Text(
                                'signIn.forgot',
                              ).tr(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'signIn.question',
                          style: TextStyle(fontSize: 14.0),
                        ).tr(),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(kDarkGreenColor),
                          ),
                          onPressed: () {
                            context.push('/register');
                          },
                          child: const Text(
                            'signIn.signUp',
                            style: TextStyle(fontSize: 14.0),
                          ).tr(),
                        )
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AuthenticationButton(
                          label: 'signIn.login'.tr(),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.go('/home');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
