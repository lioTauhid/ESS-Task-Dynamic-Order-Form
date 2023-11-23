import 'package:frutter/res/constants/app_url.dart';
import 'package:frutter/service/network/api_client.dart';
import '../../model/form.dart';

class OrderRepository {
  final ApiClient _apiClient = ApiClient();

  Future<FormModel> formDataFromApi() async {
    FormModel formModel =
        FormModel.fromJson(await _apiClient.get(AppUrl.formDataUrl));
    return formModel;
  }
}
