// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field, use_build_context_synchronously

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:scout_app/model/language_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scout_app/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AdaptiveThemeMode? savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: const Center(child: CircularProgressIndicator()),
      future: getLocale(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            return AdaptiveTheme(
              light: FlexColorScheme.light(scheme: FlexScheme.verdunHemlock)
                  .toTheme,
              dark: FlexColorScheme.dark(scheme: FlexScheme.verdunHemlock)
                  .toTheme,
              initial: widget.savedThemeMode ?? AdaptiveThemeMode.system,
              builder: (theme, darkTheme) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Scout App',
                theme: FlexThemeData.light(scheme: FlexScheme.verdunHemlock),
                darkTheme: FlexThemeData.dark(scheme: FlexScheme.verdunHemlock),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: snapshot.data,
                themeMode: theme.brightness == Brightness.light
                    ? ThemeMode.light
                    : ThemeMode.dark,
                home: const HomePage(),
              ),
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
