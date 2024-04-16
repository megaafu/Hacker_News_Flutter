import 'package:flutter/material.dart';
import 'storie_bloc.dart';
export 'storie_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StorieBloc bloc;
  StoriesProvider({Key? key, required Widget child})
      : bloc = StorieBloc(),
        super(key: key, child: child);

  @override
  // ignore: avoid_renaming_method_parameters
  bool updateShouldNotify(_) => true;
  static StorieBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()
            as StoriesProvider)
        .bloc;
  }
}
