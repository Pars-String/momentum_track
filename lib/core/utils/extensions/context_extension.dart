import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
  Object? get goRouterState => GoRouterState.of(this).extra;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLargeScreen => MediaQuery.sizeOf(this).width >= 1400;
  bool get isSmallScreen => MediaQuery.sizeOf(this).width < 600;
  bool get isMediumScreen =>
      MediaQuery.sizeOf(this).width >= 600 &&
      MediaQuery.sizeOf(this).width < 1200;
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;
  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;
  bool get isWeb => kIsWeb;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;
  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;
  bool get isLinux => Theme.of(this).platform == TargetPlatform.linux;
}
