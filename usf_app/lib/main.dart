import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'views/agendamento_page.dart';
import 'views/documento_page.dart';
import 'views/fila_page.dart';
import 'views/login_page.dart';
import 'views/tutorial_page.dart';
import 'views/justificativa_page.dart';
import 'views/justificativa_form_page.dart';
import 'views/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'USF Gerenciador',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/agendamento': (context) => const AgendamentoPage(),
        '/documentos': (context) => const DocumentosPage(),
        '/fila': (context) => const FilaPage(),
        '/tutorial': (context) => TutorialPage(),  // Adicionando a rota para o tutorial
        '/justificativa': (context) => const JustificativaPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
