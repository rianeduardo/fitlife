import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/controlador_atividades.dart';

class TelaAjustes extends StatefulWidget {
  const TelaAjustes({super.key});

  @override
  State<TelaAjustes> createState() => _TelaAjustesState();
}

class _TelaAjustesState extends State<TelaAjustes> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvarNome(ControladorAtividades controlador) {
    final novoNome = _nomeController.text.trim();
    if (novoNome.isEmpty) return;
    controlador.atualizarNomeUsuario(novoNome);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nome atualizado com sucesso')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controlador = context.watch<ControladorAtividades>();
    if (_nomeController.text.isEmpty && controlador.nomeUsuario.isNotEmpty) {
      _nomeController.text = controlador.nomeUsuario;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Modo escuro'),
              value: controlador.modoEscuro,
              onChanged: controlador.alternarModoEscuro,
            ),
            const SizedBox(height: 24),
            const Text(
              'Perfil',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        hintText: 'Digite um novo nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _salvarNome(controlador),
                      child: const Text('Alterar nome'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nome atual',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controlador.nomeUsuario.isEmpty
                          ? 'Sem nome definido'
                          : controlador.nomeUsuario,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
