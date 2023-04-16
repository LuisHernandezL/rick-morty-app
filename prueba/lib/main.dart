import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/views/character/detail_character_view.dart';
import 'package:prueba/views/home/home_view.dart';
import 'package:prueba/views/login/login.dart';

import 'views/character/character_view.dart';
import 'views/characters/bloc/characters_bloc.dart';
import 'views/characters/characters_view.dart';

import 'views/episodes/bloc/episodes_bloc.dart';
import 'views/episodes/episodes_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CharactersBloc()..add(LoadCharacters(page: 1))),
        BlocProvider(
            create: (context) => EpisodesBloc()..add(LoadEpisodes(page: 1))),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const HomeView(),
          '/characters': (context) => const CharactersView(),
          '/episodes': (context) => const EpisodesView(),
          '/character': (context) => const CharacterView(),
          '/detail': (context) => const DetailCharacterView(),
        },
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            elevation: 0,
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
