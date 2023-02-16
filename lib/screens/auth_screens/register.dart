import 'package:easy_localization/easy_localization.dart';
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
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 150.0),
                  Text(
                    'signUp.title',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                      color: kDarkGreenColor,
                    ),
                  ).tr(),
                  const SizedBox(height: 10.0),
                  Text(
                    'signUp.subtitle',
                    style: TextStyle(
                      color: kGreyColor,
                      fontSize: 16.0,
                    ),
                  ).tr(),
                  const SizedBox(height: 40.0),
                  CustomTextField(
                    key: const Key('name'),
                    validator: (value) => Validators.validateName(value!),
                    hintText: 'signUp.form.name'.tr(),
                    label: 'signUp.form.name'.tr(),
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    key: const Key('email'),
                    validator: (value) => Validators.validateEmail(value!),
                    hintText: 'signUp.form.email'.tr(),
                    label: 'signUp.form.email'.tr(),
                    icon: Icons.mail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    key: const Key('password'),
                    validator: (value) => Validators.validatePassword(value!),
                    hintText: 'signUp.form.password'.tr(),
                    label: 'signUp.form.password'.tr(),
                    icon: Icons.lock,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    key: const Key('cpassword'),
                    validator: (value) => Validators.validatePassword(value!),
                    hintText: 'signUp.form.confirm'.tr(),
                    label: 'signUp.form.confirm'.tr(),
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
                          'signUp.question',
                          style: TextStyle(fontSize: 14.0),
                        ).tr(),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(kDarkGreenColor),
                          ),
                          onPressed: () {
                            context.push('/login');
                          },
                          child: const Text(
                            'signUp.login',
                            style: TextStyle(fontSize: 14.0),
                          ).tr(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: AuthenticationButton(
                      label: 'signUp.signUp'.tr(),
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) ;
                        _formKey.currentState!.validate();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
