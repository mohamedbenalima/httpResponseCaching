import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:datacachingapp/home_page/model/pokemon.dart';
import 'package:datacachingapp/home_page/view_model/repository/local_repository.dart';
import 'package:datacachingapp/home_page/view_model/repository/remote_repository.dart';
import 'package:flutter/material.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) async {
      final RemoteRepository remoteRepository = RemoteRepository();
      final LocalRepository localRepository = LocalRepository();
      if (event is GetPokemonsEvent) {
        emit(Loading());
        final localPokemonData = await localRepository.getPokemons();
        // Checking if the local file is note empty
        if (localPokemonData.isNotEmpty) {
          log("Entred to get local data");
          // Emit local data the UI
          emit(PokemonData(data: localPokemonData));
          // Fetch data from the remote server
          final remotePokemonData = await remoteRepository.getPokemons();
          // Checking if the data is changed in the remote server,
          // if not there is no need to update data already emitted.
          // [### To simulate app behaviour when data is changed from the server,
          // just make the condition below true " if(true){.....}" ###]
          // if (true) {   // <= uncomment here to make the condition true !!
          if (jsonEncode(localPokemonData) != jsonEncode(remotePokemonData)) {
            emit(PokemonData(data: localPokemonData, isDataUpdating: true));
            await Future.delayed(const Duration(milliseconds: 1000), () {
              // Simulating data fetching time
              log('This delay is for testing purposes');
            });
            // Save the new remote data to the local file.
            localRepository.savePokemons(data: remotePokemonData);
            emit(PokemonData(data: remotePokemonData, isDataUpdating: false));
          }
        } else {
          log("Entred to get remote data");
          // Fetch data from the remote server
          final remotePokemonData = await remoteRepository.getPokemons();
          // update local file
          localRepository.savePokemons(data: remotePokemonData);
          // Emit remote data to the UI.
          emit(PokemonData(data: remotePokemonData));
        }
      }
    });
  }
}
