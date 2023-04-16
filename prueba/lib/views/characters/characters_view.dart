import 'package:flutter/material.dart';
import 'package:prueba/views/characters/bloc/characters_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  final ScrollController scrollController = ScrollController();
  int page = 1;
  late CharactersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CharactersBloc>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          _bloc.state.status != CharactersStatus.loading) {
        setState(() {
          page += 1;
        });
        _bloc.add(LoadMoreCharacters(page: page));
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state.status == CharactersStatus.failure) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: double.infinity,
                  child: const Text(
                    'Characters',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: state.status == CharactersStatus.initial
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.count(
                          controller: scrollController,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          children: state.characters.map((e) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detail',
                                  arguments: e,
                                );
                              },
                              child: Container(
                                height: 200,
                                width: 150,
                                color: const Color.fromRGBO(88, 30, 88, .892),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Hero(
                                      tag: e.heroId ?? e.id!,
                                      child: SizedBox(
                                        height: 114,
                                        width: 114,
                                        child: Image.network(
                                          e.image!,
                                        ),
                                      ),
                                    ),
                                    Text(e.name!)
                                    // SizedBox(
                                    //   height: 15,
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
