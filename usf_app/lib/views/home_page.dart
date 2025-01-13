import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFront = true; // Controla se está na frente ou verso

  void toggleCard() {
    setState(() {
      isFront = !isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.pushNamed(context, '/tutorial');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Notificações'),
                  content: const Text(
                      '1. Novo encaminhamento disponível.\n2. Atualização de consulta confirmada.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cartão Virtual
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Título sem imagem
                    Container(
                      width: double.infinity,
                      height: 80,
                      color: Colors.blue[100],
                      child: const Center(
                        child: Text(
                          'Cartão Digital',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: isFront ? _buildFrontInfo() : _buildBackInfo(),
                    ),
                    SwitchListTile(
                      title: const Text('Frente/Verso'),
                      value: !isFront,
                      onChanged: (value) {
                        toggleCard();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              // Botões principais
              _buildButtonRow(Icons.event_available, 'Agendar Consulta',
                  () => Navigator.pushNamed(context, '/agendamento')),
              const SizedBox(height: 16.0),
              _buildButtonRow(Icons.people, 'Ver Fila',
                  () => Navigator.pushNamed(context, '/fila')),
              const SizedBox(height: 16.0),
              _buildButtonRow(Icons.folder_open, 'Documentos',
                  () => Navigator.pushNamed(context, '/documentos')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Unidade de Saúde da Família',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Beneficiário: Fulano de Tal'),
          Text('Plano: USF - Básico'),
          Text('Número do Cartão: 00000001'),
          Text('Acesso: Ativo'),
        ],
      ),
    );
  }

  Widget _buildBackInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Informações Complementares',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Última Consulta: 12/01/2025'),
          Text('Próxima Consulta: 20/01/2025'),
          Text('Carência: Não se aplica'),
          Text('Status de Atendimento: Regular'),
        ],
      ),
    );
  }

  Widget _buildButtonRow(IconData icon, String text, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30.0),
        const SizedBox(width: 16.0),
        SizedBox(
          width: 250.0,
          height: 60.0,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ],
    );
  }
}
