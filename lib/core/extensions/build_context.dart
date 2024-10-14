import 'package:finwell/core/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:theme_manager_plus/theme_manager_plus.dart';

extension ContextHelper on BuildContext {
  FinThemeModel? get currentTheme {
    return themeOf<FinThemeModel>();
  }
}
