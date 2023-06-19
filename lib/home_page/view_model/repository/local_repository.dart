import 'dart:convert';
import 'dart:io';

import 'package:datacachingapp/home_page/model/pokemon.dart';
import 'package:path_provider/path_provider.dart';

class LocalRepository {
  Future<List<Pokemon>> getPokemons() async {
    Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDir.path;
    String filePath = '$appDocumentsPath/pokemons.txt';
    File file = File(filePath);
    if (!file.existsSync()) {
      return [];
    }
    String response = await file.readAsString();
    List<dynamic> data = jsonDecode(response);
    final List<Pokemon> pokemonList = data
        .map((pokemon) => Pokemon.fromJson(
              pokemon,
            ))
        .toList();
    return pokemonList;
  }

  void savePokemons({required List<Pokemon> data}) async {
    Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDir.path;
    String filePath = '$appDocumentsPath/pokemons.txt';
    File file = File(filePath);
    file.writeAsString(jsonEncode(data));
  }
}
