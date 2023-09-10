import 'package:datacachingapp/home_page/view/widgets/card_pokemon.dart';
import 'package:datacachingapp/home_page/view_model/bloc/home_page_bloc.dart';
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
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  state.isDataUpdating == true
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardPokemon(name: state.data![index].name);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Press the floating action button to get the data !!',
              ),
            );
          }
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
