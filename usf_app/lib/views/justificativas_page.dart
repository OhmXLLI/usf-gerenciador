import 'package:flutter/material.dart';
import 'justificativa_form_page.dart';

class JustificativasPage extends StatefulWidget {
  const JustificativasPage({Key? key}) : super(key: key);

  @override
  _JustificativasPageState createState() => _JustificativasPageState();
}

class _JustificativasPageState extends State<JustificativasPage> {
  List<Map<String, String>> justificativasEnviadas = [
    {
      'titulo': 'Justificativa 01',
      'data': '2025-01-10',
      'status': 'Em análise',
    },
  ];

  void _adicionarJustificativa(Map<String, String> justificativa) {
    setState(() {
      justificativasEnviadas.add(justificativa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Justificativas de Ausência')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: justificativasEnviadas.length,
        itemBuilder: (context, index) {
          final justificativa = justificativasEnviadas[index];
          return Card(
            child: ListTile(
              title: Text('${justificativa['titulo']} - ${justificativa['data']}'),
              subtitle: Text('Status: ${justificativa['status']}'),
              trailing: const Icon(Icons.visibility),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Visualizando ${justificativa['titulo']}')),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JustificativaFormPage(
                onJustificativaEnviada: (justificativa) {
                  _adicionarJustificativa(justificativa);
                  Navigator.pop(context); // Volta para a tela após o envio
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
