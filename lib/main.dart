import 'package:flutter/material.dart';
import 'package:flutter_meals_apps/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

final themedark = ThemeData(
  appBarTheme: const AppBarTheme().copyWith(centerTitle: true),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 94, 0, 131),
    // const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

final themeLight = ThemeData(
  appBarTheme: const AppBarTheme().copyWith(centerTitle: true),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Color.fromARGB(255, 94, 0, 131),
    // const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      darkTheme: themedark,
      // darkTheme: theme,
      home: const TabScreen(), // Todo ...,
    );
  }
}
