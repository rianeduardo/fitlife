import 'package:flutter/material.dart';

class BarraNavegacao extends StatelessWidget {
  final int indiceAtual;
  final Function(int) aoMudarTela;

  const BarraNavegacao({
    super.key,
    required this.indiceAtual,
    required this.aoMudarTela,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: BottomNavigationBar(
        currentIndex: indiceAtual,
        onTap: aoMudarTela,
        type: BottomNavigationBarType.fixed,
        iconSize: 28,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
