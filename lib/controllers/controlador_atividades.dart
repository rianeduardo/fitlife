import 'package:flutter/foundation.dart';
import '../models/atividade.dart';
import 'package:flutter/material.dart';

/// Controlador simples de atividades físicas e estado do usuário.
class ControladorAtividades extends ChangeNotifier {
  String? _nomeUsuario;
  bool _modoEscuro = false;
  final List<Atividade> _atividades = [];

  String get nomeUsuario => _nomeUsuario ?? '';
  bool get modoEscuro => _modoEscuro;
  List<Atividade> get atividades => List.unmodifiable(_atividades);
  int get totalAtividades => _atividades.length;
  int get atividadesConcluidas =>
      _atividades.where((atividade) => atividade.concluida).length;
  int get atividadesPendentes => totalAtividades - atividadesConcluidas;
  int get duracaoTotalConcluida => _atividades
      .where((atividade) => atividade.concluida)
      .fold(0, (sum, item) => sum + item.duracaoMinutos);

  /// Calcula o streak de dias com atividades concluídas
  int get streakDias {
    if (_atividades.isEmpty) return 0;

    final datasConcluidas = _atividades
        .where((a) => a.concluida)
        .map((a) => _normalizarData(a.dataCriacao))
        .toSet()
        .toList();

    if (datasConcluidas.isEmpty) return 0;

    datasConcluidas.sort((a, b) => b.compareTo(a));

    int streak = 1;
    for (int i = 0; i < datasConcluidas.length - 1; i++) {
      final diferenca = datasConcluidas[i]
          .difference(datasConcluidas[i + 1])
          .inDays;
      if (diferenca == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  /// Distribução de atividades por dificuldade
  Map<String, int> get distribuicaoDificuldade {
    return {
      'Fácil': _atividades
          .where((a) => a.dificuldade == DificuldadeAtividade.facil)
          .length,
      'Média': _atividades
          .where((a) => a.dificuldade == DificuldadeAtividade.media)
          .length,
      'Difícil': _atividades
          .where((a) => a.dificuldade == DificuldadeAtividade.dificil)
          .length,
    };
  }

  /// Distribução de atividades concluídas por dificuldade
  Map<String, int> get distribuicaoDificuldadeConcluida {
    return {
      'Fácil': _atividades
          .where(
            (a) => a.concluida && a.dificuldade == DificuldadeAtividade.facil,
          )
          .length,
      'Média': _atividades
          .where(
            (a) => a.concluida && a.dificuldade == DificuldadeAtividade.media,
          )
          .length,
      'Difícil': _atividades
          .where(
            (a) => a.concluida && a.dificuldade == DificuldadeAtividade.dificil,
          )
          .length,
    };
  }

  /// Duração média das atividades concluídas
  double get duracaoMedia {
    if (atividadesConcluidas == 0) return 0.0;
    return duracaoTotalConcluida / atividadesConcluidas;
  }

  /// Taxa de conclusão em percentual
  double get taxaConclusao {
    if (totalAtividades == 0) return 0.0;
    return (atividadesConcluidas / totalAtividades) * 100;
  }

  DateTime _normalizarData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  void definirNomeUsuario(String nome) {
    if (_nomeUsuario != null) return;
    final nomeTrim = nome.trim();
    if (nomeTrim.isEmpty) return;
    _nomeUsuario = nomeTrim;
    notifyListeners();
  }

  void atualizarNomeUsuario(String nome) {
    final nomeTrim = nome.trim();
    if (nomeTrim.isEmpty) return;

    _nomeUsuario = nomeTrim;

    notifyListeners();
  }

  void alternarModoEscuro(bool valor) {
    _modoEscuro = valor;
    notifyListeners();
  }

  void adicionarAtividade({
    required String titulo,
    required int duracaoMinutos,
    required DificuldadeAtividade dificuldade,
    required BuildContext context,
  }) {
    final tituloTrim = titulo.trim();
    if (tituloTrim.isEmpty || duracaoMinutos <= 0) return;
    _atividades.add(
      Atividade(
        titulo: tituloTrim,
        duracaoMinutos: duracaoMinutos,
        dificuldade: dificuldade,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Atividade criada com sucesso')),
    );
    notifyListeners();
  }

  void alternarAtividade(int indice, BuildContext context) {
    if (indice < 0 || indice >= _atividades.length) return;
    _atividades[indice].concluida = !_atividades[indice].concluida;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Status atualizado')));
    notifyListeners();
  }

  void removerAtividade(int indice, BuildContext context) {
    if (indice < 0 || indice >= _atividades.length) return;
    _atividades.removeAt(indice);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarefa excluída com sucesso')),
    );
    notifyListeners();
  }
}
