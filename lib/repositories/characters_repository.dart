import 'dart:convert';

import 'package:prueba/models/characters.dart';
import 'package:prueba/repositories/api.dart';

class CharactersRepository {
  API api = API();

  Future<Characters> getCharacters(int? page) async {
    final response = await api.sendRequest.get('character', queryParameters: {
      'page': page,
    });
    return charactersFromJson(jsonEncode(response.data));
  }

  Future<Characters> searchCharacters(String name, String status) async {
    final response = await api.sendRequest.get('character', queryParameters: {
      'name': name,
      'status': status,
    });
    return charactersFromJson(jsonEncode(response.data));
  }
}
