// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/data/model/register_model.dart';
import 'package:story_apps/data/model/sign_up_form_model.dart';
import 'package:story_apps/provider/auth_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/button_widget.dart';
import 'package:story_apps/widgets/custom_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  bool validate() {
    if (nameController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.mirror,
                    colors: [
                      Color(0X6612111F),
                      Color(0XCC12111F),
                      Color(0X9912111F),
                      Color(0XFF12111F),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomFormField(
                        controller: nameController,
                        title: 'Name',
                        isShowTitle: false,
                      ),
                      const SizedBox(height: 15),
                      CustomFormField(
                        controller: emailController,
                        title: 'Email',
                        isShowTitle: false,
                        type: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      CustomFormField(
                        controller: passwordController,
                        title: 'Password',
                        isShowTitle: false,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      Consumer<AuthProvider>(
                        builder: (context, provider, _) {
                          return CustomFilledButton(
                            onPressed: () async {
                              if (validate()) {
                                RegisterModel response =
                                    await provider.register(
                                  SignUpFormModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                                if (response.error == false) {
                                  context.goNamed('login');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(response.message),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Semua field harus diisi'),
                                  ),
                                );
                              }
                            },
                            child: provider.state == ResultState.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    AppLocalizations.of(context)!
                                        .registerButton,
                                    style: const TextStyle(
                                      color: Color(0XFF12111F),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text:
                              AppLocalizations.of(context)!.descriptionRegister,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.signinTitle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.goNamed('login');
                                },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
