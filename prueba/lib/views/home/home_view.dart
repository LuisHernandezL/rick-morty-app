import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/views/character/character_view.dart';
import 'package:prueba/views/characters/bloc/characters_bloc.dart';
import 'package:prueba/views/characters/characters_view.dart';
import 'package:prueba/views/episodes/bloc/episodes_bloc.dart';

import 'package:prueba/views/episodes/episodes_view.dart';

import 'package:prueba/widgets/card_swiper.dart';
import 'package:prueba/widgets/episode_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int indexTab = 0;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String user = ModalRoute.of(context)!.settings.arguments as String;
    return DefaultTabController(
      length: 4,
      initialIndex: indexTab,
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _home(user),
            const CharactersView(),
            const EpisodesView(),
            const CharacterView(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 40,
          child: Wrap(
            children: [
              _bottomNavigationBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    void goTo(int e) {
      setState(() {
        indexTab = e;
        tabController.animateTo(e);
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 0,
          thickness: 0.7,
          color: Color(0xff8cec8c),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            //Quitando el splash efectt
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            enableFeedback: true,
            backgroundColor: const Color.fromARGB(255, 80, 206, 228),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: indexTab,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            onTap: (e) {
              goTo(e);
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(Icons.home,
                      color: Color.fromRGBO(88, 30, 88, .892)),
                ),
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.home,
                    color: Color.fromRGBO(88, 30, 88, .61),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.people,
                    color: Color.fromRGBO(88, 30, 88, .892),
                  ),
                ),
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.people,
                    color: Color.fromRGBO(88, 30, 88, .61),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.movie_creation_outlined,
                    color: Color.fromRGBO(88, 30, 88, .892),
                  ),
                ),
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.movie_creation_outlined,
                    color: Color.fromRGBO(88, 30, 88, .61),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(88, 30, 88, .892),
                  ),
                ),
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(88, 30, 88, .61),
                  ),
                ),
                label: '',
              ),
            ],
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _home(String username) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            child: const Text(
              'Home',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            child: Text(
              'Welcome, $username',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              return CardSwiper(
                characters: state.characters,
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          BlocBuilder<EpisodesBloc, EpisodesState>(
            builder: (context, state) {
              return EpisodeSlider(
                title: 'Some Episodes',
                episodes: state.episodes,
                onNextPage: () => null,
              );
            },
          ),
        ],
      ),
    );
  }
}
