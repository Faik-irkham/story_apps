import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/ui/home_page.dart';
import 'package:story_apps/ui/login_page.dart';
import 'package:story_apps/ui/register_page.dart';

GoRouter router(BuildContext context) {
  CredentialProvider credential = Provider.of(context, listen: false);
  String initial = credential.token == null || credential.token?.isEmpty == true
      ? '/login'
      : '/';
  return GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return const RegisterPage();
        },
      ),
      GoRoute(
        path: '/',
        name: 'home_page',
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
    initialLocation: initial,
    debugLogDiagnostics: true,
    routerNeglect: true,
  );
}
