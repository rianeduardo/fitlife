import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/controlador_atividades.dart';
import '../models/atividade.dart';

class TelaAtividades extends StatefulWidget {
  const TelaAtividades({super.key});

  @override
  State<TelaAtividades> createState() => _TelaAtividadesState();
}

class _TelaAtividadesState extends State<TelaAtividades> {
  final TextEditingController _nomeAtividadeController =
      TextEditingController();
  final TextEditingController _duracaoController = TextEditingController();
  DificuldadeAtividade _dificuldadeSelecionada = DificuldadeAtividade.facil;

  @override
  void dispose() {
    _nomeAtividadeController.dispose();
    _duracaoController.dispose();
    super.dispose();
  }

  void _adicionarAtividade(ControladorAtividades controlador) {
    final nome = _nomeAtividadeController.text;
    final duracao = int.tryParse(_duracaoController.text.trim()) ?? 0;
    if (nome.trim().isEmpty || duracao <= 0) return;

    controlador.adicionarAtividade(
      titulo: nome,
      duracaoMinutos: duracao,
      dificuldade: _dificuldadeSelecionada,
      context: context,
    );
    _nomeAtividadeController.clear();
    _duracaoController.clear();
  }

  Widget _cartaoAtividade(ControladorAtividades controlador, int indice) {
    final atividade = controlador.atividades[indice];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: atividade.concluida,
          onChanged: (_) => controlador.alternarAtividade(indice, context),
        ),
        title: Text(atividade.titulo),
        subtitle: Text(
          '${atividade.duracaoMinutos} min • ${atividade.rotuloDificuldade}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () => controlador.removerAtividade(indice, context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controlador = context.watch<ControladorAtividades>();
    final pendentes = controlador.atividades
        .where((atividade) => !atividade.concluida)
        .toList();
    final concluidas = controlador.atividades
        .where((atividade) => atividade.concluida)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Atividades'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (controlador.nomeUsuario.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Olá, ${controlador.nomeUsuario}! \nPronto para uma rotina mais saudável?',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            TextField(
              controller: _nomeAtividadeController,
              decoration: const InputDecoration(
                labelText: 'Nome da atividade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _duracaoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duração (minutos)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<DificuldadeAtividade>(
                    value: _dificuldadeSelecionada,
                    decoration: const InputDecoration(
                      labelText: 'Dificuldade',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: DificuldadeAtividade.facil,
                        child: Text('Fácil'),
                      ),
                      DropdownMenuItem(
                        value: DificuldadeAtividade.media,
                        child: Text('Média'),
                      ),
                      DropdownMenuItem(
                        value: DificuldadeAtividade.dificil,
                        child: Text('Difícil'),
                      ),
                    ],
                    onChanged: (valor) {
                      if (valor != null) {
                        setState(() {
                          _dificuldadeSelecionada = valor;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Adicionar atividade'),
              onPressed: () => _adicionarAtividade(controlador),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Pendentes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (pendentes.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Nenhuma atividade pendente.'),
                    )
                  else
                    ...pendentes.map((atividade) {
                      final indice = controlador.atividades.indexOf(atividade);
                      return _cartaoAtividade(controlador, indice);
                    }),
                  const SizedBox(height: 20),
                  const Text(
                    'Concluídas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (concluidas.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text('Nenhuma atividade concluída.'),
                    )
                  else
                    ...concluidas.map((atividade) {
                      final indice = controlador.atividades.indexOf(atividade);
                      return _cartaoAtividade(controlador, indice);
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
