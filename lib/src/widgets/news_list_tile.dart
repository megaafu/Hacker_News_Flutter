import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../bloc/stories_provider.dart';
import 'dart:async';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.itemmodels,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const LoadingContainer();
            }
            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel? item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item!.id}');
          },
          title: Text(
            '${item!.title}',
            style: const TextStyle(
              color: Color(0xFF1f0b0b),
              fontSize: 17,
            ),
          ),
          subtitle: Text(
            '${item.score} points',
            style: const TextStyle(
              color: Color(0xFFeb3434),
              fontSize: 12,
            ),
          ),
          hoverColor: const Color(0x662f2f2f),
          trailing: Column(
            children: [
              const Icon(
                Icons.comment,
                color: Color(0xFFeb3434),
              ),
              Text(
                "${item.kids == null ? 0 : item.kids!.length}",
                style: const TextStyle(
                  color: Color(0xFFeb3434),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 6,
        ),
      ],
    );
  }
}
