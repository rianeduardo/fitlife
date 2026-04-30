import 'package:flutter/material.dart';
import 'tela_atividades.dart';
import 'tela_dashboard.dart';
import 'tela_ajustes.dart';
import '../widgets/barra_navegacao.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indiceTelaAtual = 0;

  final List<Widget> _telas = [
    const TelaAtividades(),
    const TelaDashboard(),
    const TelaAjustes(),
  ];

  void _mudarTela(int indice) {
    setState(() {
      _indiceTelaAtual = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceTelaAtual],
      bottomNavigationBar: BarraNavegacao(
        indiceAtual: _indiceTelaAtual,
        aoMudarTela: _mudarTela,
      ),
    );
  }
}
