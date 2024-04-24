// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:scout_app/main.dart';
import 'package:scout_app/model/language.dart';
import 'package:scout_app/model/language_constants.dart';

class Main extends StatelessWidget {
  const Main({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).homePage),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
              ),
              onChanged: (Language? language) async {
                Locale loc = await getLocale();
                if (language != null &&
                    language.languageCode != loc.languageCode) {
                  Locale locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Hello"),
        ),
      ),
    );
  }
}
