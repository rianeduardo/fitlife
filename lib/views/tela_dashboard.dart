import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/controlador_atividades.dart';

class TelaDashboard extends StatelessWidget {
  const TelaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controlador = context.watch<ControladorAtividades>();
    final distribuicao = controlador.distribuicaoDificuldade;
    final distribuicaoConcluida = controlador.distribuicaoDificuldadeConcluida;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard(
              title: 'Atividades totais',
              value: controlador.totalAtividades.toString(),
              icon: Icons.list_alt,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Concluídas',
              value: controlador.atividadesConcluidas.toString(),
              icon: Icons.check_circle_outline,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Pendentes',
              value: controlador.atividadesPendentes.toString(),
              icon: Icons.pending,
              color: Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Tempo concluído',
              value: '${controlador.duracaoTotalConcluida} min',
              icon: Icons.access_time,
              color: Colors.purple,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Streak',
              value: '${controlador.streakDias} dias',
              icon: Icons.local_fire_department,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Taxa de conclusão',
              value: '${controlador.taxaConclusao.toStringAsFixed(1)}%',
              icon: Icons.trending_up,
              color: const Color(0xFF6B5BFF),
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              title: 'Duração média',
              value: '${controlador.duracaoMedia.toStringAsFixed(1)} min',
              icon: Icons.calculate,
              color: const Color(0xFF00D4FF),
            ),
            const SizedBox(height: 24),
            // Seção de Distribuição por Dificuldade
            const Text(
              'Distribuição por Dificuldade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDistribuicaoItem(
                      label: 'Fácil',
                      total: distribuicao['Fácil'] ?? 0,
                      concluida: distribuicaoConcluida['Fácil'] ?? 0,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildDistribuicaoItem(
                      label: 'Média',
                      total: distribuicao['Média'] ?? 0,
                      concluida: distribuicaoConcluida['Média'] ?? 0,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    _buildDistribuicaoItem(
                      label: 'Difícil',
                      total: distribuicao['Difícil'] ?? 0,
                      concluida: distribuicaoConcluida['Difícil'] ?? 0,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                radius: 20,
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildDistribuicaoItem({
  required String label,
  required int total,
  required int concluida,
  required Color color,
}) {
  final percentual = total == 0 ? 0.0 : (concluida / total) * 100;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(
            '$concluida/$total',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: total == 0 ? 0 : concluida / total,
          minHeight: 8,
          backgroundColor: color.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '${percentual.toStringAsFixed(0)}%',
        style: const TextStyle(fontSize: 11, color: Colors.grey),
      ),
    ],
  );
}
