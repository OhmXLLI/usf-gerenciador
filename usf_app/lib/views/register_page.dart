import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Adicionando FocusNodes
  final FocusNode _nomeFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _senhaFocusNode = FocusNode();

  @override
  void dispose() {
    // Liberando os recursos ao fechar a tela
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();

    _nomeFocusNode.dispose();
    _emailFocusNode.dispose();
    _senhaFocusNode.dispose();
    super.dispose();
  }

  Future<void> _cadastrar(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:xxxxx/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: '{"nome": "${_nomeController.text}", "email": "${_emailController.text}", "senha": "${_senhaController.text}"}',
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Navigator.pop(context); // Volta para a tela de login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              focusNode: _nomeFocusNode,
              decoration: const InputDecoration(labelText: 'Nome Completo'),
              onTap: () {
                if (!_nomeFocusNode.hasFocus) {
                  _nomeFocusNode.requestFocus(); // Garante que o campo receba o foco
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: const InputDecoration(labelText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              onTap: () {
                if (!_emailFocusNode.hasFocus) {
                  _emailFocusNode.requestFocus();
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _senhaController,
              obscureText: true,
              focusNode: _senhaFocusNode,
              decoration: const InputDecoration(labelText: 'Senha'),
              onTap: () {
                if (!_senhaFocusNode.hasFocus) {
                  _senhaFocusNode.requestFocus();
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _cadastrar(context),
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
