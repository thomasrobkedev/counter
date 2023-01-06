import 'dart:convert';
import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';

final penGreen = AnsiPen()..green(bold: true);
final penRed = AnsiPen()..red(bold: true);
final penBlue = AnsiPen()..blue(bold: true);
final penYellow = AnsiPen()..yellow(bold: true);

Future<void> main([List<String>? args]) async {
  switch (args?[0]) {
    case 'help':
      return Help().execute();
    case 'phrasepull':
      return await PhrasePull().execute();
    case null:
      return stdout.writeln(penRed('Error: missing target'));
    default:
      stdout.writeln(penRed('Error: unknown target'));
      stdout.writeln('Usage: make.dart <target> [options]');
  }
}

class Help {
  void execute() {
    final content = File('Makefile').readAsStringSync();
    final matches = RegExp(r'([a-zA-Z_-]+):.*?## (.*)\n').allMatches(content);

    for (var match in matches) {
      stdout.writeln(penGreen(match[1]!.padRight(24)) + match[2]!);
    }
  }
}

class PhrasePull {
  /// Public project id and read-only access token
  static const _accountID = 'ad15e351acba38f92c7e3b78283ca45e65d511834e975ebf72a579cbbe542398';
  static const _projectID = '5c4a6b51edeaccd231efa81a22c70bbe';

  /// Phrase locales
  static const _locales = ['de-DE', 'en-US', 'hr-HR', 'hu-HU', 'nl-NL', 'pl-PL', 'sk-SK', 'cs-CZ', 'bg-BG', 'sl-SI', 'ro-RO', 'sr-RS', 'lv-LV', 'lt-LT', 'et-EE'];

  late final Map<String, dynamic> _additionalTranslations;

  Future<void> execute() async {
    _additionalTranslations = jsonDecode(File('additional_translations.json').readAsStringSync());

    for (var locale in _locales) {
      await _processLocale(locale);
    }

    stdout.writeln('Running flutter gen-l10n...');
    await Process.run('flutter', ['gen-l10n'], runInShell: true);

    stdout.writeln('Running flutter analyze...');
    await Process.run('flutter', ['analyze'], runInShell: true);
  }

  Future<void> _processLocale(String locale) async {
    // Without the delay -> HTTP-429 "Too Many Requests"
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      // Refactor into a flutter compatible format.
      final flutterCompatibleLocale = locale.split('-').first;

      // Fetch the .arb-File from Phrase
      final url = 'https://api.phrase.com/v2/projects/$_projectID/locales/$locale/download?access_token=$_accountID&file_format=arb';
      final contents = (await Dio().request<String>(url)).toString();
      // PrettyPrint it into the project and correct the locale for flutter
      final Map<String, dynamic> json = const JsonDecoder().convert(contents);
      json['@@locale'] = flutterCompatibleLocale;
      _injectAdditionalTranslations(json, flutterCompatibleLocale);
      final str = const JsonEncoder.withIndent('  ').convert(json);
      final path = 'lib/l10n/app_$flutterCompatibleLocale.arb';
      File(path).writeAsStringSync(str);

      stdout.writeln('$locale: ${penGreen('success')}');
    } catch (e) {
      stdout.writeln('$locale: ${penRed(e.toString())}');
    }
  }

  void _injectAdditionalTranslations(Map<String, dynamic> json, String locale) {
    for (var entry in _additionalTranslations.entries) {
      final translations = entry.value as Map<String, dynamic>;

      json[entry.key] = translations[locale] ?? translations['de'];
      json['@${entry.key}'] = {'type': 'text'};
    }
  }
}
