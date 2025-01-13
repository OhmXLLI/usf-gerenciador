import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: 'root@usf.com');
  final TextEditingController _passwordController = TextEditingController(text: 'root');
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final token = await AuthService().login(_emailController.text, _passwordController.text);

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao realizar login')));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nova imagem no topo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'img/logo_usf.png', // Caminho da imagem
                height: 150.0,  // Tamanho da imagem
                width: 150.0,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Unidade de Saúde da Família',  // Novo título
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Entrar'),
                  ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navega para a tela de registro
              },
              child: const Text('Não tem uma conta? Cadastre-se!'),
            ),
          ],
        ),
      ),
    );
  }
}
