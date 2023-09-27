import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:story_app/localization.dart';
import 'package:story_app/reusable/localization.dart';

class FlagIconWidget extends StatelessWidget {
  Color? colors;
  FlagIconWidget({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(
            Icons.flag,
            color: colors!,
          ),
          items: AppLocalizations.supportedLocales.map((Locale locale) {
            final flag = Localization.getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Center(
                child: Text(
                  flag,
                  style: Theme.of(context).textTheme.headline4,
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
      ),
    );
  }
}
