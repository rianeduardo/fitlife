import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/controlador_atividades.dart';
import 'views/tela_onboarding.dart';
import 'tema.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ControladorAtividades(),
      child: const FitLifeApp(),
    ),
  );
}

class FitLifeApp extends StatelessWidget {
  const FitLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.watch<ControladorAtividades>();

    return MaterialApp(
      title: 'Fit Life',
      debugShowCheckedModeBanner: false,
      themeMode: controlador.modoEscuro ? ThemeMode.dark : ThemeMode.light,
      theme: TemaFitLife.temaNormal,
      darkTheme: TemaFitLife.temaEscuro,
      home: const TelaOnboarding(),
    );
  }
}
