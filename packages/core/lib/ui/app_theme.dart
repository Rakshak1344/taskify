import 'package:core/ui/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData.from(useMaterial3: true, colorScheme: lightColorScheme);
  }

  static ThemeData get dark {
    return light.copyWith(colorScheme: darkColorScheme);
  }
}
