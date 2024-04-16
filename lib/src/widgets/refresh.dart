import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  const Refresh({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      color: const Color(0xFF01b3e3),
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
