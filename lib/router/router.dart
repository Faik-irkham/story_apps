import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/bottom_navigation.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/ui/add_story_page.dart';
import 'package:story_apps/ui/detail_story_page.dart';
import 'package:story_apps/ui/home_page.dart';
import 'package:story_apps/ui/login_page.dart';
import 'package:story_apps/ui/map_page.dart';
import 'package:story_apps/ui/pick_map_page.dart';
import 'package:story_apps/ui/register_page.dart';

GoRouter newRouter(BuildContext context) {
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
            routes: [
              GoRoute(
                path: 'pick',
                name: 'map_pick',
                builder: (context, state) => const PickMapPage(),
              ),
            ],
          ),
          GoRoute(
              path: ':id',
              name: 'detail',
              builder: (context, state) =>
                  DetailStoryPage(id: state.pathParameters['id']!),
              routes: [
                GoRoute(
                  path: 'map/:lat/:lon',
                  name: 'map',
                  builder: (context, state) => MapPage(
                    id: state.pathParameters['id']!,
                    lat: state.pathParameters['lat']!,
                    lon: state.pathParameters['lon']!,
                  ),
                ),
              ])
        ],
      ),
    ],
    initialLocation: initial,
    routerNeglect: true,
  );
}
