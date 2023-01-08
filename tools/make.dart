import 'dart:convert';
import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

final penGreen = AnsiPen()..green(bold: true);
final penRed = AnsiPen()..red(bold: true);
final penBlue = AnsiPen()..blue(bold: true);
final penYellow = AnsiPen()..yellow(bold: true);

Future<void> main([List<String>? args]) async {
  switch (args?[0]) {
    case 'help':
      return Help().execute();
    case 'translate':
      return await Translate().execute();
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

class Translate {
  static const _locales = ['de-DE', 'en-US'];
  late final Map<String, dynamic> _translations;

  Future<void> execute() async {
    _translations = jsonDecode(File('tools/translations.json').readAsStringSync());

    for (var locale in _locales) {
      await _processLocale(locale);
    }

    stdout.writeln('Running flutter gen-l10n...');
    await Process.run('flutter', ['gen-l10n'], runInShell: true);

    stdout.writeln('Running flutter analyze...');
    await Process.run('flutter', ['analyze'], runInShell: true);
  }

  Future<void> _processLocale(String locale) async {
    try {
      final flutterCompatibleLocale = locale.split('-').first;
      final json = <String, dynamic>{};
      json['@@locale'] = flutterCompatibleLocale;
      _injectTranslations(json, flutterCompatibleLocale);
      final str = const JsonEncoder.withIndent('  ').convert(json);
      final path = 'lib/l10n/app_$flutterCompatibleLocale.arb';
      File(path).writeAsStringSync(str);
      stdout.writeln('$locale: ${penGreen('success')}');
    } catch (e) {
      stdout.writeln('$locale: ${penRed(e.toString())}');
    }
  }

  void _injectTranslations(Map<String, dynamic> json, String locale) {
    for (var entry in _translations.entries) {
      final translations = entry.value as Map<String, dynamic>;

      json[entry.key] = translations[locale] ?? translations['de'];
      json['@${entry.key}'] = {'type': 'text'};
    }
  }
}
