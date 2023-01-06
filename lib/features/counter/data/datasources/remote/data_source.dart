import '../../../../../core/api/client.dart';
import '../../../../../core/mixins/remote_data_source.dart';
import '../../models/model.dart';

class CounterRemoteDataSource with AppRemoteDataSourceMixin {
  final AppApiClient _apiClient;

  CounterRemoteDataSource(this._apiClient);

  Future<List<CounterModel>> getAll() async {
    final items = await request<Iterable>(
      () => _apiClient.get('/counters'),
    );
    return items.map((item) => CounterModel.fromJson(item)).toList();
  }

  Future<CounterModel> get(int id) async {
    final item = await request<Json>(
      () => _apiClient.get('/counters/$id'),
    );
    return CounterModel.fromJson(item);
  }

  Future<CounterModel> update(CounterModel counterModel) async {
    final item = await request<Json>(
      () => _apiClient.put('/counters/${counterModel.id}', counterModel.toJson()),
    );
    return CounterModel.fromJson(item);
  }

  Future<CounterModel> create(CounterModel counterModel) async {
    final item = await request(
      () => _apiClient.post('/counters', counterModel.toJson()),
    );
    return CounterModel.fromJson(item);
  }

  Future<void> delete(int id) async {
    await request<void>(
      () => _apiClient.delete('/counters/$id'),
    );
  }

  Future<List<CounterModel>> reset() async {
    final items = await request<Iterable>(
      () => _apiClient.get('/counters/reset'),
    );
    return items.map((item) => CounterModel.fromJson(item)).toList();
  }
}
