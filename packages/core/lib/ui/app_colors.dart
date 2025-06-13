import 'package:flutter/material.dart';

const seedColor = Color(0xFF634AFF);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.dark,
);

/// A class that holds all color schemes for the app.
class ColorSchemes {
  // Orange-based Sporty ColorScheme for Light Theme
  final ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF5722),
    // Deep Orange
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFECE3),
    onPrimaryContainer: Color(0xFF3E1300),
    secondary: Color(0xFF2196F3),
    // Blue for contrast
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD0E4FF),
    onSecondaryContainer: Color(0xFF001D36),
    tertiary: Color(0xFF4CAF50),
    // Green for accent
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFB8F5B9),
    onTertiaryContainer: Color(0xFF002204),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    outline: Color(0xFF85736E),
    outlineVariant: Color(0xFFD8C2BB),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF201A18),
    surfaceContainerHighest: Color(0xFFF5DED6),
    onSurfaceVariant: Color(0xFF53433E),
    inverseSurface: Color(0xFF362F2D),
    onInverseSurface: Color(0xFFFBEEEA),
    inversePrimary: Color(0xFFFFB59D),
    surfaceTint: Color(0xFFFF5722),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );

  // Orange-based Sporty ColorScheme for Dark Theme
  final ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB59D),
    // Light Orange
    onPrimary: Color(0xFF5F1D00),
    primaryContainer: Color(0xFFE03A00),
    onPrimaryContainer: Color(0xFFFFDBCF),
    secondary: Color(0xFF90CAFF),
    // Light Blue for contrast
    onSecondary: Color(0xFF00325A),
    secondaryContainer: Color(0xFF004881),
    onSecondaryContainer: Color(0xFFD1E4FF),
    tertiary: Color(0xFF9DDC9E),
    // Light Green for accent
    onTertiary: Color(0xFF003909),
    tertiaryContainer: Color(0xFF005311),
    onTertiaryContainer: Color(0xFFB9F8B9),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    outline: Color(0xFF9F8D87),
    outlineVariant: Color(0xFF53433E),
    surface: Color(0xFF201A18),
    onSurface: Color(0xFFEDE0DC),
    surfaceContainerHighest: Color(0xFF53433E),
    onSurfaceVariant: Color(0xFFD8C2BB),
    inverseSurface: Color(0xFFEDE0DC),
    onInverseSurface: Color(0xFF201A18),
    inversePrimary: Color(0xFFBE380D),
    surfaceTint: Color(0xFFFFB59D),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );
}
