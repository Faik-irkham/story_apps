import 'package:flutter/material.dart';
import 'package:story_apps/build_variant/flavor_config.dart';
import 'package:story_apps/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: FlavorType.free,
    values: const FlavorValues(
      appType: "Free",
    ),
  );
  runApp(const MyApp());
}

// flutter run -t lib/main_free.dart