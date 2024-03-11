import 'package:flutter/material.dart';
import 'package:story_apps/widgets/custom_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 60,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/bg-login.png',
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.cyanAccent,
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const CustomFormField(
                  title: 'Email',
                  isShowTitle: false,
                ),
                const SizedBox(height: 15),
                const CustomFormField(
                  title: 'Password',
                  isShowTitle: false,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Login'),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
