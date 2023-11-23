import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/form.dart';
import '../../repository/order_repo/order_repository.dart';

class OrderViewModel extends GetxController {
  final OrderRepository _repo = OrderRepository();

  Rx<FormModel> formModel = FormModel().obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadFormData();
  }

  Future<void> loadFormData() async {
    formModel.value = await _repo.formDataFromApi();
    loading.value = false;
  }

  Future<String> writeCsvToDisk() async {
    List<List<String>> data = [
      ["Label", "Value"],
      for (Fields f in formModel.value.sections![0].fields!.toList())
        [f.properties!.label.toString(), f.properties!.defaultValue.toString()]
    ];
    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-${DateTime.now()}.csv";
    final File file = File(path);
    await file.writeAsString(csvData);
    return path;
  }
}
