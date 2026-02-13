import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 6, 197, 108),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 22, 118, 73),
  brightness: Brightness.dark,
);

//fontFamily: GoogleFonts.spaceMono().fontFamily

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,

          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: getAppTextTheme(kDarkColorScheme),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: getAppTextTheme(kColorScheme),
      ),
      // themeMode: ThemeMode.system,// default
      home: Expenses(),
    ),
  );
}

TextTheme getAppTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'SpaceMono',
      fontWeight: FontWeight.bold,
      color: colorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'SpaceMono',
      color: colorScheme.onSecondaryContainer,
    ),
  );
}
