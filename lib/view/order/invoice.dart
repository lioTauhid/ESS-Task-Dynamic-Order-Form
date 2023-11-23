import 'package:flutter/material.dart';
import 'package:frutter/model/form.dart';
import 'package:frutter/res/constants/value.dart';
import 'package:get/get.dart';

import '../../res/components/common_widgets.dart';
import '../../res/constants/app_color.dart';
import '../../utils/utils.dart';
import '../../view_model/order/order_view_model.dart';

class InvoiceDialog extends StatelessWidget {
  InvoiceDialog(this._formModel, {super.key});

  final FormModel _formModel;

  final OrderViewModel _orderViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _formModel.sections!.length,
                  itemBuilder: (c, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          for (Fields f
                              in _formModel.sections![i].fields!.toList())
                            Container(
                              height: 80,
                              width: Size.infinite.width,
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppColor.textSecondary, width: 2)),
                              child: Text(
                                  "${f.properties!.label}: ${f.properties!.defaultValue}"),
                            ),
                        ],
                      ),
                    );
                  })),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: 150,
            child: normalButton("Save to file", AppColor.primaryColor,
                AppColor.white, Values.fontSmall, onPressed: () {
              _orderViewModel.writeCsvToDisk().then((value) {
                Utils.showSnackBar("File saved as CSV in - $value");
              });
            }),
          ),
        ],
      ),
    );
  }
}
