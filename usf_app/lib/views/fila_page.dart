import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math';

class FilaPage extends StatefulWidget {
  const FilaPage({Key? key}) : super(key: key);

  @override
  _FilaPageState createState() => _FilaPageState();
}

class _FilaPageState extends State<FilaPage> {
  int _posicaoFila = 0;
  bool _autenticado = false;

  Future<void> _validarPresenca() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validar Presença'),
          content: const Text('Simulando geolocalização e validação de token...'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _autenticado = true;
                  _posicaoFila = Random().nextInt(10) + 1; // Simula posição na fila
                });
                Navigator.of(context).pop(); // Fecha o alerta
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _atualizarPosicao() {
    setState(() {
      if (_posicaoFila > 1) {
        _posicaoFila--; // Simula que a fila está andando
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você é o próximo!')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fila de Espera')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_autenticado)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.gps_fixed, size: 30.0),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    width: 250.0,
                    height: 60.0,
                    child: ElevatedButton(
                      onPressed: _validarPresenca,
                      child: const Text(
                        'Validar Presença',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  const SizedBox(height: 16.0),
                  const SpinKitThreeInOut(
                    color: Colors.blueAccent,
                    size: 60.0,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Personagem caminhando...',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Sua posição atual na fila: $_posicaoFilaº lugar',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.update, size: 30.0),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: 250.0,
                        height: 60.0,
                        child: ElevatedButton(
                          onPressed: _atualizarPosicao,
                          child: const Text(
                            'Atualizar Posição',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
