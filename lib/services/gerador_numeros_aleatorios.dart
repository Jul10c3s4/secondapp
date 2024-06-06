import 'dart:math';

class GeradorNumerosAleatorios {
  static gerarNumeroAleatorio(int range) {
    Random randomizador = Random();
    return randomizador.nextInt(range);
  }
}
