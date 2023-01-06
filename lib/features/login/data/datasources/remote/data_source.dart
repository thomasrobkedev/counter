import '../../../../../core/api/client.dart';
import '../../../../../core/mixins/remote_data_source.dart';
import '../../models/model.dart';

class LoginRemoteDataSource with AppRemoteDataSourceMixin {
  final AppApiClient _apiClient;

  LoginRemoteDataSource(this._apiClient);

  Future<String> login(LoginModel model) async {
    final data = model.toJson();
    final response = await request<Json>(
      () => _apiClient.put('/login', data),
    );
    return response['token'];
  }
}
