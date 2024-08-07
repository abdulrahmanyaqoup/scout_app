// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scout_app/main.dart';
import 'package:scout_app/model/language.dart';
import 'package:scout_app/model/language_constants.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

bool positive = true;
bool transilatee = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.none,
        toolbarHeight: MediaQuery.of(context).size.height * 0.130,
        backgroundColor: AdaptiveTheme.of(context).mode.isDark
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dark_light(),
                transilate(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Center(
              child: Text(
                translation(context).welcome,
                style: GoogleFonts.rubik(
                  textStyle: const TextStyle(wordSpacing: 4, fontSize: 20),
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/dot.svg',
              height: 200,
              width: 200,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  AnimatedToggleSwitch<bool> dark_light() {
    return AnimatedToggleSwitch<bool>.dual(
        current: positive,
        first: false,
        second: true,
        spacing: 25.0,
        animationDuration: const Duration(milliseconds: 300),
        style: ToggleStyle(
          borderColor: Theme.of(context).colorScheme.secondaryContainer,
          indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        customStyleBuilder: (context, local, global) {
          if (global.position <= 0.0) {
            return ToggleStyle(
              backgroundColor: Theme.of(context).colorScheme.primary,
            );
          }
          return ToggleStyle(
            backgroundGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
              stops: [
                global.position - (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                global.position + max(0, 2 * (global.position - 0.5)) * 0.7,
              ],
            ),
          );
        },
        borderWidth: 3.0,
        height: 30.0,
        indicatorSize: const Size.fromWidth(25.0),
        onChanged: (b) {
          setState(() {
            positive = b;

            if (AdaptiveTheme.of(context).mode.isDark) {
              AdaptiveTheme.of(context).setLight();
            } else {
              AdaptiveTheme.of(context).setDark();
            }
          });
        },
        iconBuilder: (value) => value
            ? Icon(Icons.light_mode_outlined,
                color: Theme.of(context).colorScheme.primary, size: 15.0)
            : Icon(Icons.dark_mode_outlined,
                color: Theme.of(context).colorScheme.primary, size: 15.0),
        textBuilder: (value) => value
            ? Center(
                child: Text(
                  'Light',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              )
            : Center(
                child: Text(
                  'Dark',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              ));
  }

  AnimatedToggleSwitch<bool> transilate() {
    return AnimatedToggleSwitch<bool>.dual(
        current: transilatee,
        first: false,
        second: true,
        spacing: 20.0,
        animationDuration: const Duration(milliseconds: 300),
        style: ToggleStyle(
          borderColor: Theme.of(context).colorScheme.secondaryContainer,
          indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        customStyleBuilder: (context, local, global) {
          if (global.position <= 0.0) {
            return ToggleStyle(
              backgroundColor: Theme.of(context).colorScheme.primary,
            );
          }
          return ToggleStyle(
            backgroundGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryContainer,
              ],
              stops: [
                global.position - (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                global.position + max(0, 2 * (global.position - 0.5)) * 0.7,
              ],
            ),
          );
        },
        borderWidth: 3.0,
        height: 30.0,
        indicatorSize: const Size.fromWidth(25.0),
        onChanged: (b) async {
          print(b);
          transilatee = b;
          Locale loc = await getLocale();
          if (loc.languageCode != 'ar') {
            Locale locale = await setLocale('ar');
            MyApp.setLocale(context, locale);
            print("ar");
          } else {
            if (loc.languageCode != 'en') {
              Locale locale = await setLocale('en');
              MyApp.setLocale(context, locale);
              print("en");
            }
          }
          setState(() {
            transilatee = b;
          });
        },
        iconBuilder: (value) => value
            ? IconButton(
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: Text(
                  Language.languageList()[1].flag,
                  style: const TextStyle(fontSize: 10.0),
                ),
              )
            : IconButton(
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: Text(
                  Language.languageList()[0].flag,
                  style: const TextStyle(fontSize: 10.0),
                ),
              ),
        textBuilder: (value) => value
            ? Center(
                child: Text(
                  'Ar',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              )
            : Center(
                child: Text(
                  'En',
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              ));
  }
}
