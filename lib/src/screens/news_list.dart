import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/src/bloc/storie_bloc.dart';
import '../bloc/stories_provider.dart';
import '../widgets/news_list_tile.dart';
import '../widgets/refresh.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70.0,
        title: const Text('Hacker News'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF4d3d3d),
          fontSize: 22,
        ),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StorieBloc bloc) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(35)),
        color: const Color(0xe9f2f2f2),
      ),
      child: StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Refresh(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, int index) {
                int id = snapshot.data![index];
                bloc.fetchItem(id);
                return NewsListTile(
                  itemId: id,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
