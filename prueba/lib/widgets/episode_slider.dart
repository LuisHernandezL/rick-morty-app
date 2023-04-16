// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prueba/models/episodes.dart';

class EpisodeSlider extends StatefulWidget {
  final List<Episode> episodes;
  final String? title;
  final Function onNextPage;

  const EpisodeSlider(
      {Key? key, required this.episodes, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<EpisodeSlider> createState() => _EpisodeSliderState();
}

class _EpisodeSliderState extends State<EpisodeSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 500) {
    //     widget.onNextPage();
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.title!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: ListView.builder(
              // controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: widget.episodes.length,
              itemBuilder: (__, int index) => _EpisodePoster(
                widget.episodes[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EpisodePoster extends StatelessWidget {
  final Episode episode;

  const _EpisodePoster(this.episode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            'Title: ${episode.name!}',
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            'Air Date :${episode.airDate!}',
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
