import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frutter/res/components/custom_dialog.dart';
import 'package:frutter/view/order/invoice.dart';
import 'package:frutter/view_model/order/order_view_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/form.dart';
import '../../res/components/common_widgets.dart';
import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../utils/utils.dart';

class CustomOrder extends StatelessWidget {
  CustomOrder({super.key});

  final OrderViewModel _orderViewModel = Get.put(OrderViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        title: const Text("Order Form Page"),
        leading: IconButton(
          onPressed: () {
            showCustomDialog(
                context,
                "Warning!",
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "All your input data will lost, are you sure to back?",
                        style: TextStyle(fontSize: Values.fontMediumExtra),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Utils.hidePopup();
                                Utils.hidePopup();
                              },
                              child: const Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Utils.hidePopup();
                              },
                              child: const Text("No")),
                        ],
                      )
                    ],
                  ),
                ),
                MediaQuery.of(context).size.height ~/ 2,
                50);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return Form(
                  key: _formKey,
                  child: _orderViewModel.loading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount:
                              _orderViewModel.formModel.value.sections!.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i <
                                          _orderViewModel.formModel.value
                                              .sections![index].fields!
                                              .toList()
                                              .length;
                                      i++)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: setTypedWidget(
                                          _orderViewModel.formModel.value
                                              .sections![index].fields![i],
                                          index,
                                          i),
                                    )
                                ],
                              ),
                            );
                          }),
                );
              }),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 150,
              child: normalButton("Order", AppColor.primaryColor,
                  AppColor.white, Values.fontSmall, onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  showCustomDialog(context, "Invoice",
                      InvoiceDialog(_orderViewModel.formModel.value), 50, 20);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget setTypedWidget(Fields? fields, int sectionIndex, int fieldIndex) {
    TextEditingController controller = TextEditingController(
        text: fields!.properties!.defaultValue.toString() ?? "");

    if (fields.properties!.type == "text") {
      // For Text Field
      return textFieldWithLabel(controller, fields.properties!.hintText ?? "",
          fields.properties!.label ?? "",
          fields: fields, onChanged: (v) {
        _orderViewModel.formModel.value.sections![sectionIndex]
            .fields![fieldIndex].properties!.defaultValue = v;
      });
    } else if (fields.properties!.type == "dropDownList") {
      // For DropdownMenu
      List<String> list = [];
      for (var m in jsonDecode(fields.properties!.listItems.toString())) {
        list.add(m["name"]);
      }
      return DropdownMenu<String>(
        initialSelection: list[0],
        onSelected: (String? value) {
          _orderViewModel.formModel.value.sections![sectionIndex]
              .fields![fieldIndex].properties!.defaultValue = value;
        },
        dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(value: value, label: value);
        }).toList(),
      );
    } else if (fields.properties!.type == "viewText") {
      // For Text view
      return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.textSecondary, width: 2)),
        child: Text(fields.properties!.label.toString()),
      );
    } else if (fields.properties!.type == "imageView") {
      // For Image view
      return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.textSecondary, width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            fields.properties!.defaultValue.toString().split(":").first ==
                    "https"
                ? Image.network(fields.properties!.defaultValue.toString())
                : Image.file(File(fields.properties!.defaultValue.toString())),
            iconTextBtn(
                Icon(
                  Icons.photo,
                  color: AppColor.textPrimary,
                ),
                "Add Photo",
                Colors.transparent,
                AppColor.textPrimary,
                Values.fontSmall, onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                _orderViewModel.formModel.value.sections![sectionIndex]
                    .fields![fieldIndex].properties!.defaultValue = image.path;
                _orderViewModel.formModel.refresh();
              } else {
                Utils.showSnackBar("Error picking image!");
              }
            }),
          ],
        ),
      );
    } else {
      // For Number Text view
      return textFieldWithLabel(controller, fields.properties!.hintText ?? "",
          fields.properties!.label ?? "",
          fields: fields, onChanged: (v) {
        _orderViewModel.formModel.value.sections![sectionIndex]
            .fields![fieldIndex].properties!.defaultValue = v;
      });
    }
  }

  Widget textFieldWithLabel(
      TextEditingController controller, String hint, String label,
      {Fields? fields, prefIcon, Function(String)? onChanged}) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        style:
            TextStyle(fontSize: Values.fontSmall, color: AppColor.textPrimary),
        onChanged: onChanged,
        validator: (value) {
          if (fields?.properties?.maxLength != null) {
            if (value == null ||
                value.isEmpty ||
                value.length > fields!.properties!.maxLength!.toInt()) {
              return 'Please enter some text. Max: ${fields!.properties!.maxLength}';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          fillColor: AppColor.secondaryBackground,
          prefixIcon: prefIcon,
          hintText: hint,
          label: Text(label),
          hintStyle: TextStyle(
              fontSize: Values.fontSmall, color: AppColor.textPrimary),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.textPrimary)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.primaryColor)),
        ));
  }
}
