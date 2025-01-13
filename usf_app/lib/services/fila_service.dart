import 'dart:convert';
import 'package:http/http.dart' as http;

class FilaService {
  final String _baseUrl = 'http://localhost:xxxxx/api';

  Future<int?> getPosicaoPaciente(String pacienteId) async {
    final response = await http.get(Uri.parse('$_baseUrl/fila/$pacienteId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['posicao']; // Retorna a posição na fila
    } else {
      return null; // Retorna null em caso de erro
    }
  }
}
