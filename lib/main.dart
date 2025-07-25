import 'package:clinica_estetica_landing/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ClinicaEsteticaApp());
}

class ClinicaEsteticaApp extends StatelessWidget {
  const ClinicaEsteticaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turmalina Estética',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB8A48B),
          primary: const Color(0xFFB8A48B),
          secondary: const Color(0xFF7C6A58),
        ),
        textTheme: GoogleFonts.interTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
