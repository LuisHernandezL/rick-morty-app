import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba/views/episodes/bloc/episodes_bloc.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  final ScrollController scrollController = ScrollController();
  int page = 1;
  late EpisodesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<EpisodesBloc>(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          _bloc.state.status != EpisodesStatus.loading) {
        setState(() {
          page += 1;
        });
        _bloc.add(LoadMoreEpisodes(page: page));
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
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<EpisodesBloc, EpisodesState>(
      builder: (context, state) {
        if (state.status == EpisodesStatus.loading &&
            state.status == EpisodesStatus.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == EpisodesStatus.failure) {
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
                    'Episodes',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.episodes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.episodes[index].name ?? "Not found"),
                        subtitle: Text(
                            '${state.episodes[index].episode} - ${state.episodes[index].airDate}'),
                      );
                    },
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
