import 'package:datacachingapp/home_page/view/widgets/card_pokemon.dart';
import 'package:datacachingapp/home_page/view_model/bloc/home_page_bloc.dart';
import 'package:datacachingapp/home_page/view_model/repository/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Data caching'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: state is Loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is PokemonData
                    ? ListView.builder(
                        itemCount: state.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardPokemon(name: state.data![index].name);
                        },
                      )
                    : Container(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomePageBloc>().add(GetPokemonsEvent()),
        child: const Center(
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
