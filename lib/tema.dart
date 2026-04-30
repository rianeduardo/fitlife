import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TemaFitLife {
  /// Cores personalizadas para o tema claro
  static const Color _corPrimaria = Color(0xFF6B5BFF); // Roxo vibrante
  static const Color _corSecundaria = Color(0xFF00D4FF); // Ciano
  static const Color _corAcento = Color(0xFFFF6B6B); // Vermelho coral
  static const Color _corFundoClaro = Color(0xFFFAFAFC); // Quase branco
  static const Color _corTextoPrincipalClaro = Color(0xFF1A1A2E); // Quase preto

  /// Cores personalizadas para o tema escuro
  static const Color _corFundoEscuro = Color(0xFF0F0F1E); // Azul muito escuro
  static const Color _corSuperficieEscura = Color(0xFF1A1A2E); // Azul escuro
  static const Color _corTextoPrincipalEscuro = Color(0xFFF5F5F7);

  static ThemeData get temaNormal {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _corFundoClaro,
      primaryColor: _corPrimaria,
      colorScheme: ColorScheme.light(
        primary: _corPrimaria,
        secondary: _corSecundaria,
        tertiary: _corAcento,
        surface: Colors.white,
        surfaceContainer: const Color(0xFFEEEEF5),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _corTextoPrincipalClaro,
      ),
      textTheme: GoogleFonts.lexendTextTheme(
        ThemeData.light().textTheme.apply(
          bodyColor: _corTextoPrincipalClaro,
          displayColor: _corTextoPrincipalClaro,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _corPrimaria,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _corPrimaria,
        unselectedItemColor: Colors.grey[400],
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _corPrimaria,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFFF5F5F5),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _corPrimaria, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFF757575)),
      ),
    );
  }

  static ThemeData get temaEscuro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _corFundoEscuro,
      primaryColor: _corPrimaria,
      colorScheme: ColorScheme.dark(
        primary: _corPrimaria,
        secondary: _corSecundaria,
        tertiary: _corAcento,
        surface: _corSuperficieEscura,
        surfaceContainer: const Color(0xFF252538),
        onPrimary: Colors.white,
        onSecondary: _corFundoEscuro,
        onSurface: _corTextoPrincipalEscuro,
      ),
      textTheme: GoogleFonts.lexendTextTheme(
        ThemeData.dark().textTheme.apply(
          bodyColor: _corTextoPrincipalEscuro,
          displayColor: _corTextoPrincipalEscuro,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _corSuperficieEscura,
        foregroundColor: _corTextoPrincipalEscuro,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: _corTextoPrincipalEscuro,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _corSuperficieEscura,
        selectedItemColor: _corSecundaria,
        unselectedItemColor: Colors.grey[600],
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: _corSuperficieEscura,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _corPrimaria,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xFF252538),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF3A3A52)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF3A3A52)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _corSecundaria, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFFA0A0B0)),
      ),
    );
  }
}
