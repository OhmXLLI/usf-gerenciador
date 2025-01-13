import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class JustificativaFormPage extends StatefulWidget {
  final Function(Map<String, String>) onJustificativaEnviada;

  const JustificativaFormPage({Key? key, required this.onJustificativaEnviada}) : super(key: key);

  @override
  _JustificativaFormPageState createState() => _JustificativaFormPageState();
}

class _JustificativaFormPageState extends State<JustificativaFormPage> {
  final TextEditingController _motivoController = TextEditingController();
  String? _arquivoSelecionado;

  Future<void> _selecionarArquivo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Permitir apenas PDF
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _arquivoSelecionado = result.files.single.path!;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo Selecionado: ${result.files.single.name}')),
      );
    }
  }

  void _enviarJustificativa() {
    if (_motivoController.text.isEmpty || _arquivoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o motivo e selecione um arquivo PDF.')),
      );
      return;
    }

    final justificativa = {
      'titulo': 'Justificativa - ${DateTime.now().toString().substring(0, 10)}',
      'data': DateTime.now().toString().substring(0, 10),
      'status': 'Em análise',
      'arquivo': _arquivoSelecionado!,
    };

    widget.onJustificativaEnviada(justificativa);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Justificativa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explique o motivo da sua ausência:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _motivoController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Motivo da Justificativa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Anexe um documento em PDF:'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _selecionarArquivo,
              icon: const Icon(Icons.upload_file),
              label: const Text('Selecionar Arquivo PDF'),
            ),
            if (_arquivoSelecionado != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Arquivo Selecionado: ${_arquivoSelecionado!.split('/').last}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _enviarJustificativa,
              child: const Text('Enviar Justificativa'),
            ),
          ],
        ),
      ),
    );
  }
}
