import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/controlador_atividades.dart';
import 'tela_principal.dart';

class TelaOnboarding extends StatefulWidget {
  const TelaOnboarding({super.key});

  @override
  State<TelaOnboarding> createState() => _TelaOnboardingState();
}

class _TelaOnboardingState extends State<TelaOnboarding> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _iniciarApp(BuildContext context) {
    final controlador = context.read<ControladorAtividades>();
    controlador.definirNomeUsuario(_nomeController.text);
    if (controlador.nomeUsuario.isEmpty) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TelaPrincipal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controlador = context.watch<ControladorAtividades>();
    if (controlador.nomeUsuario.isNotEmpty) {
      return const TelaPrincipal();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('Fit Life'), elevation: 0),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/background.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.35)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'FitLife',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Seu app de atividades físicas simples e eficaz.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Digite seu nome',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _iniciarApp(context),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Começar', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
