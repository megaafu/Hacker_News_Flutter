import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class StorieBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;

  Stream<Map<int, Future<ItemModel?>>> get itemmodels => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StorieBloc() {
    _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  clearCache() {
    return _repository.clearCache();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
