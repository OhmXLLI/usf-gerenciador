import 'package:flutter/material.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({Key? key}) : super(key: key);

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  String? _especialidade;
  String? _periodo;
  bool _requerEncaminhamento = false;

  final List<String> semEncaminhamento = ['Clínico Geral', 'Odontologia'];
  final List<String> comEncaminhamento = ['Cardiologia', 'Dermatologia'];

  Future<void> _agendarConsulta() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Consulta agendada com sucesso!')),
    );
  }

  void _verificarEncaminhamento() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Encaminhamento Necessário'),
          content: const Text('Você possui encaminhamento para esta especialidade?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _agendarConsulta(); // Prossegue com o agendamento
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Você precisa passar por um Clínico Geral antes de consultar esta especialidade.',
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Consulta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Especialidade', style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _especialidade,
              items: [
                const DropdownMenuItem(
                  enabled: false,
                  child: Text('Sem Encaminhamento:', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...semEncaminhamento.map((String especialidade) {
                  return DropdownMenuItem(
                    value: especialidade,
                    child: Text(especialidade),
                  );
                }).toList(),
                const DropdownMenuItem(
                  enabled: false,
                  child: Text('---------------------------'),
                ),
                const DropdownMenuItem(
                  enabled: false,
                  child: Text('Com Encaminhamento:', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...comEncaminhamento.map((String especialidade) {
                  return DropdownMenuItem(
                    value: especialidade,
                    child: Text(especialidade),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _especialidade = value;
                  _requerEncaminhamento = comEncaminhamento.contains(value);
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            const Text('Período', style: TextStyle(fontSize: 18)),
            DropdownButtonFormField<String>(
              value: _periodo,
              items: ['Manhã', 'Tarde'].map((String periodo) {
                return DropdownMenuItem(
                  value: periodo,
                  child: Text(periodo),
                );
              }).toList(),
              onChanged: (value) => setState(() => _periodo = value),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_especialidade == null || _periodo == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos.')),
                    );
                    return;
                  }
                  if (_requerEncaminhamento) {
                    _verificarEncaminhamento(); // Verifica encaminhamento para especialidades que exigem
                  } else {
                    _agendarConsulta(); // Realiza o agendamento direto
                  }
                },
                child: const Text('Agendar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
