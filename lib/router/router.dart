import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/bottom_navigation.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/ui/add_story_page.dart';
import 'package:story_apps/ui/detail_story_page.dart';
import 'package:story_apps/ui/home_page.dart';
import 'package:story_apps/ui/login_page.dart';
import 'package:story_apps/ui/register_page.dart';

GoRouter router(BuildContext context) {
  CredentialProvider credential = Provider.of(context, listen: false);
  String initial = credential.token == null || credential.token?.isEmpty == true
      ? '/login'
      : '/bottomNav';
  return GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'register',
            name: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/bottomNav',
        name: 'bottomNav',
        builder: (context, state) => const CustomBottomNavigation(),
        routes: [
          GoRoute(
            path: 'home',
            name: 'homePage',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'upload',
            name: 'upload',
            builder: (context, state) => const AddStoryPage(),
          ),
          GoRoute(
            path: ':id',
            name: 'detail',
            builder: (context, state) =>
                DetailStoryPage(id: state.pathParameters['id']!),
          )
        ],
      ),
    ],
    initialLocation: initial,
    debugLogDiagnostics: true,
    routerNeglect: true,
  );
}
