import 'dart:convert';

import 'package:prueba/models/episodes.dart';
import 'package:prueba/repositories/api.dart';

class EpisodeRepository {
  API api = API();

  Future<Episodes> getEpisodes() async {
    final response = await api.sendRequest.get('episode');
    return episodesFromJson(jsonEncode(response.data));
  }
}
