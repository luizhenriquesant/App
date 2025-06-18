// core/services/api_service.dart
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'https://seu-backend.com/api/analyze'; 

  Future<Map<String, dynamic>> analyzeFood(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse(_baseUrl));
    var file = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    var response = await request.send();
    var resp = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Erro ao analisar imagem');
    }
  }
}