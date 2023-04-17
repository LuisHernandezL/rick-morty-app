// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:prueba/models/characters.dart';

class DetailCharacterView extends StatelessWidget {
  const DetailCharacterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(character),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(character),
            _Overview(character),
            // // _Overview(),
            // // _Overview(),
            // CastingCards(movie.id)
          ]),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Character character;
  const _CustomAppBar(this.character);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            character.name!,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(character.image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Character character;
  const _PosterAndTitle(this.character);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: character.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.gif'),
                image: NetworkImage(character.image!),
                height: 150,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 250),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(character.name!,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(
                  character.gender!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Icon(Icons.circle,
                          size: 15,
                          color: character.status == 'Alive'
                              ? Colors.green
                              : Colors.red),
                      SizedBox(width: 5),
                      Text(
                        character.status!,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Character character;
  const _Overview(this.character);
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Text(
            'Location: ${character.location!.name!}',
            style: textStyle,

            // style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Origin: ${character.origin!.name!}',
            style: textStyle,

            // style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Type: ${character.type!}',
            style: textStyle,

            // style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            'Specie: ${character.species!}',
            style: textStyle,

            // style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}
