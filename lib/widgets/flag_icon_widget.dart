import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_apps/common/common.dart';
import 'package:story_apps/common/localization.dart';
import 'package:story_apps/provider/localizations_provider.dart';

class FlagWidget extends StatelessWidget {
  const FlagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(Icons.flag),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
              ),
            ),
            onTap: () {
              final provider =
                  Provider.of<LocalizationProvider>(context, listen: false);
              provider.setLocale(locale);
            },
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
