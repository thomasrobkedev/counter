import 'package:flutter/material.dart';

const success = Color(0xFF4CAF50);
const info = Color(0xFF2196F3);
const warning = Color(0xFFFFEB3B);
const alert = Color(0xFFF44336);

CustomColors lightCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF4CAF50),
  success: Color(0xFF006E1C),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF94F990),
  onSuccessContainer: Color(0xFF002204),
  sourceInfo: Color(0xFF2196F3),
  info: Color(0xFF0061A4),
  onInfo: Color(0xFFFFFFFF),
  infoContainer: Color(0xFFD1E4FF),
  onInfoContainer: Color(0xFF001D36),
  sourceWarning: Color(0xFFFFEB3B),
  warning: Color(0xFF695F00),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFF9E534),
  onWarningContainer: Color(0xFF201C00),
  sourceAlert: Color(0xFFF44336),
  alert: Color(0xFFBB1614),
  onAlert: Color(0xFFFFFFFF),
  alertContainer: Color(0xFFFFDAD5),
  onAlertContainer: Color(0xFF410001),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF4CAF50),
  success: Color(0xFF78DC77),
  onSuccess: Color(0xFF00390A),
  successContainer: Color(0xFF005313),
  onSuccessContainer: Color(0xFF94F990),
  sourceInfo: Color(0xFF2196F3),
  info: Color(0xFF9ECAFF),
  onInfo: Color(0xFF003258),
  infoContainer: Color(0xFF00497D),
  onInfoContainer: Color(0xFFD1E4FF),
  sourceWarning: Color(0xFFFFEB3B),
  warning: Color(0xFFDBC90A),
  onWarning: Color(0xFF363100),
  warningContainer: Color(0xFF4F4800),
  onWarningContainer: Color(0xFFF9E534),
  sourceAlert: Color(0xFFF44336),
  alert: Color(0xFFFFB4A9),
  onAlert: Color(0xFF690002),
  alertContainer: Color(0xFF930005),
  onAlertContainer: Color(0xFFFFDAD5),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.sourceInfo,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceAlert,
    required this.alert,
    required this.onAlert,
    required this.alertContainer,
    required this.onAlertContainer,
  });

  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? sourceInfo;
  final Color? info;
  final Color? onInfo;
  final Color? infoContainer;
  final Color? onInfoContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceAlert;
  final Color? alert;
  final Color? onAlert;
  final Color? alertContainer;
  final Color? onAlertContainer;

  @override
  CustomColors copyWith({
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? sourceInfo,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceAlert,
    Color? alert,
    Color? onAlert,
    Color? alertContainer,
    Color? onAlertContainer,
  }) {
    return CustomColors(
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      sourceInfo: sourceInfo ?? this.sourceInfo,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceAlert: sourceAlert ?? this.sourceAlert,
      alert: alert ?? this.alert,
      onAlert: onAlert ?? this.onAlert,
      alertContainer: alertContainer ?? this.alertContainer,
      onAlertContainer: onAlertContainer ?? this.onAlertContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      sourceInfo: Color.lerp(sourceInfo, other.sourceInfo, t),
      info: Color.lerp(info, other.info, t),
      onInfo: Color.lerp(onInfo, other.onInfo, t),
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t),
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceAlert: Color.lerp(sourceAlert, other.sourceAlert, t),
      alert: Color.lerp(alert, other.alert, t),
      onAlert: Color.lerp(onAlert, other.onAlert, t),
      alertContainer: Color.lerp(alertContainer, other.alertContainer, t),
      onAlertContainer: Color.lerp(onAlertContainer, other.onAlertContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
