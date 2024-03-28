// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/data/model/sign_in_model.dart';
import 'package:story_apps/provider/auth_provider.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/utils/response_state.dart';
import 'package:story_apps/widgets/button_widget.dart';
import 'package:story_apps/widgets/custom_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool validate() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
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
                      Text(
                        AppLocalizations.of(context)!.signinTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 50),
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
                      Consumer2<AuthProvider, CredentialProvider>(
                        builder: (context, auth, cred, _) {
                          return CustomFilledButton(
                            onPressed: () async {
                              if (validate()) {
                                String email = emailController.text;
                                String password = passwordController.text;
                                SignInModel response = await auth.login(
                                  email,
                                  password,
                                );
                                if (response.error == false) {
                                  context.goNamed('bottomNav');
                                  var result = response.loginResult;
                                  cred.setCredential(
                                      result.token, result.name, email);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(response.message),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text(AppLocalizations.of(context)!
                                        .textAuthWarning),
                                  ),
                                );
                              }
                            },
                            child: auth.state == ResultState.loading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.signinTitle,
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
                          text: AppLocalizations.of(context)!.descriptionLogin,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  AppLocalizations.of(context)!.registerButton,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.goNamed('register');
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
