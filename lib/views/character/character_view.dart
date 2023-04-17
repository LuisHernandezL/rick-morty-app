import 'package:flutter/material.dart';
import 'package:prueba/views/characters/bloc/characters_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({super.key});

  @override
  State<CharacterView> createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  bool showSearchBar = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(),
      child: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state.status == CharactersStatus.failure) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return Scaffold(
              body: _body(context, state),
            );
          }
        },
      ),
    );
  }

  Widget _body(BuildContext context, CharactersState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 15,
        ),
        _searchBar(context),
        state.characters.length > 1
            ? Expanded(
                child: state.status == CharactersStatus.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: state.characters.length,
                        itemBuilder: (context, index) {
                          var char = state.characters[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: char,
                              );
                            },
                            child: Card(
                              color: const Color.fromRGBO(88, 30, 88, .892),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Hero(
                                        tag: char.heroId!,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(char.image!),
                                          radius: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          char.name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Status: ',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: char.status!,
                                                style: TextStyle(
                                                  color: char.status == 'Alive'
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Specie: ${char.species!}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Location: ${char.location!.name!}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Gender: ${char.gender!}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            : state.status == CharactersStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Center(
                    child: Text(
                      "Busca a tu personaje favorito",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
      ],
    );
  }

  Padding _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: showSearchBar ? MediaQuery.of(context).size.width - 45 : 36,
        height: 36,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedOpacity(
                    opacity: showSearchBar ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      height: 36,
                      width: MediaQuery.of(context).size.width - 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromRGBO(251, 251, 251, 1),
                      ),
                      child: TextField(
                        style: const TextStyle(
                            color: Color.fromRGBO(88, 30, 88, .892)),
                        onSubmitted: (value) async {
                          context.read<CharactersBloc>().add(
                                SearchCharacters(name: value),
                              );
                          setState(() {
                            showSearchBar = !showSearchBar;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          // errorBorder: InputBorder.none,
                          // disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15, bottom: 10),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(123, 128, 141, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          showSearchBar = !showSearchBar;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(49, 64, 93, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
