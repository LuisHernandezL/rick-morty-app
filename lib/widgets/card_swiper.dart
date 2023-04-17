import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:prueba/models/characters.dart';
import 'package:prueba/utils/images.dart';

class CardSwiper extends StatelessWidget {
  final List<Character> characters;
  const CardSwiper({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (characters.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Swiper(
        itemCount: characters.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.46,
        itemBuilder: (_, int index) {
          final character = characters[index];
          character.heroId = 'swiper-${character.id}';
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: character);
            },
            // Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: character.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage(Images.noImage),
                  image: NetworkImage(character.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
