import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/src/models/item_model.dart';
import '../bloc/comments_provider.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  const NewsDetail({Key? key, required this.itemId})
      : super(
          key: key,
        );

  @override
  Widget build(context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text('Detail News'),
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Color(0xFFb57070),
          fontSize: 22,
        ),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return Container(
      margin: const EdgeInsets.only(top:5),
      color: const Color(0xB3f2f2f2),
      child: StreamBuilder(
        stream: bloc.itemWithComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel?>>?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final itemFuture = snapshot.data![itemId];
          return FutureBuilder(
            future: itemFuture,
            builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return buildList(itemSnapshot.data, snapshot.data);
            },
          );
        },
      ),
    );
  }

  Widget buildList(ItemModel? item, Map<int, Future<ItemModel?>>? itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    if (item!.kids != null) {
      final commentsList = item.kids!.map(
        (kidId) {
          return Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: 0,
          );
        },
      ).toList();
      children.addAll(commentsList);
    }

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel? item) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        '${item!.title}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1f0b0b),
        ),
      ),
    );
  }
}
