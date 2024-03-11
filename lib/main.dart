import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_apps/ui/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ],
    initialLocation: '/login',
    debugLogDiagnostics: true,
  );

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
