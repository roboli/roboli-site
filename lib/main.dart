import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roboli_site/router/router.dart';

void main() {
  runApp(const SiteApp());
}

class SiteApp extends StatelessWidget {
  const SiteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      title: 'Roboli\'s Site',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black87,
        tabBarTheme: const TabBarTheme(
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
        ),
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ).apply(bodyColor: Colors.white),
      ),
      routerConfig: router,
    );
  }
}
