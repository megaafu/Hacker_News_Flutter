import 'package:flutter/material.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'package:html/parser.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel?>>? itemMap;
  final int depth;
  const Comment({
    Key? key,
    required this.itemId,
    required this.itemMap,
    required this.depth,
  }) : super(key: key);

  @override
  Widget build(context) {
    double left = (depth + 1) * 16;
    return FutureBuilder(
      future: itemMap![itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin:
                EdgeInsets.only(left: left + 5, top: 8, bottom: 8, right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: const Color(0x599e5d5d),
            ),
            height: 35,
          );
        }
        final item = snapshot.data;
        final children = <Widget>[
          Container(
            margin: EdgeInsets.only(left: left, top: 8, right: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: const Color(0x599e5d5d),
            ),
            child: ListTile(
              title: Text(
                buildText(item),
                style: const TextStyle(
                  color: Color(0xFFf2f2f2),
                ),
              ),
              subtitle: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xFF825555),
                    size: 18,
                  ),
                  item!.by == '' ? const Text('Deleted') : Text('${item.by}'),
                ],
              ),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: left,
              ),
            ),
          ),
          const Divider(
            height: 6,
          ),
        ];

        if (item.kids != null) {
          for (var kidId in item.kids!) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            );
          }
        }
        return Column(
          children: children,
        );
      },
    );
  }

  String buildText(ItemModel? item) {
    final text = item!.text;
    var document = parse(text);
    final converter = parse(document.body!.text).documentElement!.text;
    return converter;
  }
}
