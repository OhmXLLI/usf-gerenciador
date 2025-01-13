class AuthService {
  Future<String?> login(String email, String password) async {
    // Simplificação: autenticação direta sem comunicação com backend
    if (email == 'root@usf.com' && password == 'root') {
      return 'fake_token'; // Simulamos o retorno de um token fictício
    } else {
      return null;
    }
  }
}
