part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class Loading extends HomePageState {}

class PokemonData extends HomePageState {
  final List<Pokemon>? data;

  PokemonData({this.data});
}
