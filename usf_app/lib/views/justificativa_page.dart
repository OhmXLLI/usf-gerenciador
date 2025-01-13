import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class JustificativaPage extends StatefulWidget {
  const JustificativaPage({Key? key}) : super(key: key);

  @override
  _JustificativaPageState createState() => _JustificativaPageState();
}

class _JustificativaPageState extends State<JustificativaPage> {
  final TextEditingController _motivoController = TextEditingController();
  File? _documentoSelecionado;

  Future<void> _selecionarDocumento() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      if (file.lengthSync() > 5 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Arquivo maior que 5 MB. Selecione um arquivo menor.')),
        );
        return;
      }
      setState(() {
        _documentoSelecionado = file;
      });
    }
  }

  void _enviarJustificativa() {
    if (_motivoController.text.isEmpty || _documentoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos e anexe o documento.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Justificativa enviada com sucesso! Status: Em análise.')),
    );

    Navigator.pop(context); // Voltar à tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Justificativa de Ausência')),
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
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Motivo da Justificativa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Anexe o documento de justificativa (PDF, JPG, PNG - máx. 5 MB):'),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _selecionarDocumento,
              icon: const Icon(Icons.upload_file),
              label: Text(_documentoSelecionado == null ? 'Selecionar Arquivo' : 'Arquivo Selecionado'),
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
