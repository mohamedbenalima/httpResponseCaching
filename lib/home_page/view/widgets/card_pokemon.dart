import 'package:flutter/material.dart';

class CardPokemon extends StatelessWidget {
  final String name;
  const CardPokemon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        leading: SizedBox(
          height: 35,
          child: Image.asset('assets/images/pokemon.png'),
        ),
      ),
    );
  }
}
