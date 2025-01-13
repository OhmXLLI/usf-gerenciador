import 'package:flutter/material.dart';
import 'justificativa_form_page.dart'; // Import do formulário de envio de justificativas

class DocumentosPage extends StatelessWidget {
  const DocumentosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> categorias = [
      'Justificativas de Ausência',
      'Encaminhamentos Médicos',
      'Resultados de Exames',
      'Receituário Médico',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Documentos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: const Icon(Icons.folder),
              title: Text(categorias[index]),
              onTap: () {
                if (categorias[index] == 'Justificativas de Ausência') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JustificativaDetalhesPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DocumentosDetalhesPage(
                        categoria: categorias[index],
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class DocumentosDetalhesPage extends StatelessWidget {
  final String categoria;
  const DocumentosDetalhesPage({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> documentosExemplo = [
      'Documento 1 - ${DateTime.now().toString().substring(0, 10)}',
      'Documento 2 - ${DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10)}',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(categoria)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: documentosExemplo.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(documentosExemplo[index]),
              subtitle: Text('Categoria: $categoria'),
              trailing: const Icon(Icons.download),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Baixando ${documentosExemplo[index]}...')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class JustificativaDetalhesPage extends StatefulWidget {
  const JustificativaDetalhesPage({Key? key}) : super(key: key);

  @override
  _JustificativaDetalhesPageState createState() => _JustificativaDetalhesPageState();
}

class _JustificativaDetalhesPageState extends State<JustificativaDetalhesPage> {
  List<Map<String, String>> justificativas = [
    {
      'titulo': 'Justificativa 01',
      'data': '2025-01-10',
      'status': 'Em análise',
      'motivoRecusa': '',
    },
    {
      'titulo': 'Justificativa 02',
      'data': '2025-01-09',
      'status': 'Recusada',
      'motivoRecusa': 'Documento ilegível.',
    },
    {
      'titulo': 'Justificativa 03',
      'data': '2025-01-08',
      'status': 'Aceita',
      'motivoRecusa': '',
    },
  ];

  void _adicionarJustificativa(Map<String, String> justificativa) {
    setState(() {
      justificativas.add(justificativa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Justificativas de Ausência')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: justificativas.length,
        itemBuilder: (context, index) {
          final justificativa = justificativas[index];
          return Card(
            child: ListTile(
              title: Text('${justificativa['titulo']} - ${justificativa['data']}'),
              subtitle: Text('Status: ${justificativa['status']}'),
              onTap: () {
                if (justificativa['status'] == 'Recusada') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Motivo da Recusa'),
                        content: Text(justificativa['motivoRecusa'] ?? ''),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Visualizando documento enviado...')),
                  );
                }
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
                  Navigator.pop(context);
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
