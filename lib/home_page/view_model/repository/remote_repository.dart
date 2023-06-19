import 'package:datacachingapp/home_page/model/pokemon.dart';
import 'package:dio/dio.dart';

class RemoteRepository {
  final dio = Dio();

  Future<List<Pokemon>> getPokemons() async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon');
    List<dynamic> data = response.data['results'];
    final List<Pokemon> pokemonList = data
        .map((pokemon) => Pokemon.fromJson(
              pokemon,
            ))
        .toList();
    return pokemonList;
  }
}
