/// Modelo simples de atividade física.
class Atividade {
  Atividade({
    required this.titulo,
    required this.duracaoMinutos,
    required this.dificuldade,
    this.concluida = false,
    DateTime? dataCriacao,
  }) : dataCriacao = dataCriacao ?? DateTime.now();

  final String titulo;
  final int duracaoMinutos;
  final DificuldadeAtividade dificuldade;
  bool concluida;
  final DateTime dataCriacao;

  String get rotuloDificuldade {
    switch (dificuldade) {
      case DificuldadeAtividade.facil:
        return 'Fácil';
      case DificuldadeAtividade.media:
        return 'Média';
      case DificuldadeAtividade.dificil:
        return 'Difícil';
    }
  }
}

enum DificuldadeAtividade { facil, media, dificil }
