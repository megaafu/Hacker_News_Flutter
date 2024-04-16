import 'package:flutter/material.dart';
import 'package:news/src/screens/news_detail.dart';
import 'screens/news_list.dart';
import 'bloc/stories_provider.dart';
import 'bloc/comments_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hacker News',
          theme: ThemeData(
            brightness: Brightness.light,
            secondaryHeaderColor: Colors.transparent,
            scaffoldBackgroundColor: const Color(0xFFb8a9a9),
          ),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''));
          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}
