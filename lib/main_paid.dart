import 'package:flutter/material.dart';
import 'package:story_apps/build_variant/flavor_config.dart';
import 'package:story_apps/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    flavor: FlavorType.paid,
    values: const FlavorValues(
      appType: "Paid",
    ),
  );
  runApp(const MyApp());
}
