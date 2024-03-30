import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/data/api/api_service.dart';
import 'package:story_apps/data/preference/auth_preference.dart';
import 'package:story_apps/provider/auth_provider.dart';
import 'package:story_apps/provider/credential_provider.dart';
import 'package:story_apps/provider/localizations_provider.dart';
import 'package:story_apps/provider/story_provider.dart';
import 'package:story_apps/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CredentialProvider(
            preferences: AuthPreference(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => StoryProvider(
            apiService: ApiService(),
            preferences: AuthPreference(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalizationProvider(),
        ),
      ],
      child: Consumer2<CredentialProvider, LocalizationProvider>(
        builder: (context, auth, provider, _) {
          return MaterialApp.router(
            locale: provider.locale,
            theme: ThemeData(
              useMaterial3: true,
            ),
            routerConfig: newRouter(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
