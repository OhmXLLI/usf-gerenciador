import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Agendar Consulta",
          body: "Clique aqui para agendar consultas e exames.",
          image: Image.asset('assets/consulta.png'),
        ),
        PageViewModel(
          title: "Ver Fila",
          body: "Veja sua posição na fila de atendimento em tempo real.",
          image: Image.asset('assets/fila.png'),
        ),
        PageViewModel(
          title: "Documentos",
          body: "Veja encaminhamentos, resultados de exames e receitas médicas.",
          image: Image.asset('assets/documentos.png'),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      showSkipButton: true,
      skip: const Text('Pular'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Entendi'),
    );
  }
}
