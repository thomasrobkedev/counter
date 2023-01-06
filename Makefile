.DEFAULT_GOAL := help

help:
	@dart tools/make.dart 'help'

# ------------------------------------------------------------
run: ## Startet die App
	@flutter run

run-external-api: ## Startet die App mit der externen API
	@flutter run lib/main_external_api.dart

# ------------------------------------------------------------
tests: ## Führt die Integrationstests EINMALIG aus.
	@flutter test integration_test/main_test.dart

tests-watch: ## Führt die Integrationstests aus und wartet dann auf [SHIFT + R] für einen erneuten Lauf. 
	@flutter run integration_test/main_test.dart

unit-tests: ## Führt die Unit-Tests aus. Genauer: alle Dateien mit folgendem Muster: /test/**_test.dart
	@flutter test
.PHONY: test

# ------------------------------------------------------------
format: format-lib format-tests ## format-lib und format-tests.

format-lib: ## Formatiert und bereinigt alle App-Files. https://docs.flutter.dev/development/tools/formatting, https://dart.dev/tools/dart-fix
	@flutter format lib --line-length 999
	@cd lib && dart fix --apply

format-tests: ## Formatiert und bereinigt alle Test-Files.
	@flutter format integration_test --line-length 999
	@cd integration_test && dart fix --apply

lint: ## Analysiert den Code und zeigt (Formatierungs-)Probleme unter Berücksichtigung von analysis_options.yaml
	@flutter analyze

# ------------------------------------------------------------
clean: ## Bereinigt den Projekt-Cache. Löscht die temporären Projekt-Ordner und -Dateien (z.B. .dart_tools) und erstellt diese neu
	@flutter clean
	@flutter pub get
	@flutter gen-l10n
	@flutter analyze

# ------------------------------------------------------------
phrasepull: ## Lädt die Sprachdateien von phrase.com und speichert sie als ARB Dateien ab.
	@dart tools/make.dart 'phrasepull'
