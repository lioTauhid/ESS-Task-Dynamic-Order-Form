import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frutter/view_model/feedback/feedback_view_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../res/components/common_widgets.dart';
import '../../res/components/custom_dialog.dart';
import '../../res/constants/app_color.dart';
import '../../res/constants/value.dart';
import '../../utils/utils.dart';

class Feedback extends StatelessWidget {
  Feedback({super.key});

  final FeedbackViewModel feedbackViewModel = Get.put(FeedbackViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackground,
      appBar: AppBar(
        title: const Text("Feedback Page"),
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
            bigTextField(TextEditingController(), 4),
            const SizedBox(height: 10),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.textSecondary, width: 2)),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    feedbackViewModel.imagePath.value == ""
                        ? const Text("no image")
                        : Image.file(File(feedbackViewModel.imagePath.value)),
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
                        feedbackViewModel.imagePath.value = image.path;
                      } else {
                        Utils.showSnackBar("Error picking image!");
                      }
                    }),
                  ],
                );
              }),
            ),
            const SizedBox(height: 10),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.textSecondary, width: 2)),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          feedbackViewModel.timerText.value,
                          style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: Values.fontSmall),
                        ),
                        Text(
                          "Path: ",
                          style: TextStyle(
                              color: AppColor.textSecondary,
                              fontSize: Values.fontSmall),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          feedbackViewModel.playAudio =
                              !feedbackViewModel.playAudio;
                          if (feedbackViewModel.playAudio) {
                            feedbackViewModel.playFunc();
                          }
                          if (!feedbackViewModel.playAudio) {
                            feedbackViewModel.stopPlayFunc();
                          }
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: AppColor.red,
                        ))
                  ],
                );
              }),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 150,
              child: normalButton("Submit", AppColor.primaryColor,
                  AppColor.white, Values.fontSmall,
                  onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget bigTextField(TextEditingController controller, int maxLine,
      {prefIcon}) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        maxLines: maxLine,
        style:
            TextStyle(fontSize: Values.fontSmall, color: AppColor.textPrimary),
        decoration: InputDecoration(
          fillColor: AppColor.secondaryBackground,
          prefixIcon: prefIcon,
          hintText: "Write here...",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.textPrimary)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColor.primaryColor)),
        ));
  }
}
