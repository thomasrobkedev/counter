// ignore_for_file: constant_identifier_names

enum Testkey {
  drawer,
  drawer_menuCounters,
  drawer_menuSettings,
  drawer_menuLogin,
  drawer_menuLogout,

  login_page,
  login_pNumber,
  login_password,
  login_submitButton,
  login_homepageButton,

  logout_page,
  logout_loginButton,

  sessionExpired_loginButton,

  counterList_page,
  counterList_card,
  counterList_cardName,
  counterList_cardValue,
  counterList_popupMenu,
  counterList_reorder,

  counterDetail_page,
  counterDetail_title,
  counterDetail_value,
  counterDetail_buttonPlus,
  counterDetail_buttonMinus,
  counterDetail_buttonReset,
  counterDetail_popupMenu,
  counterDetail_confirmDialog_ok,
  counterDetail_confirmDialog_cancel,

  settings_page,
  settings_title,
  settings_language,
  settings_languageLabel,
  settings_languageValue,
  settings_theme,
  settings_themeLabel,
  settings_themeValue,
  settings_houseNumber,
  settings_houseNumberValue,
  settings_houseNumberLabel,
  settings_houseNumberClear,
  settings_submitButton,

  dropdown,
  dropdown_item,
  dropdown_item_icon,
}

extension TestkeyExtension on Testkey {
  String get enabled => toString().enabled;
  String get disabled => toString().disabled;
  String get active => toString().active;
  String get inactive => toString().inactive;
  String get selected => toString().selected;

  String isEnabled(bool isEnabled) => isEnabled ? enabled : disabled;
  String isActive(bool isActive) => isActive ? active : inactive;
  String isSelected(bool isSelected) => isSelected ? selected : toString();

  String append(dynamic suffix) => toString() + suffix.toString();
  String appendWithUnderscore(dynamic suffix) => append('_$suffix');
}

extension TestkeyStringExtension on String {
  String get enabled => '${this}--enabled';
  String get disabled => '${this}--disabled';
  String get active => '${this}--active';
  String get inactive => '$this}--inactive';
  String get selected => '${this}--selected';
}
