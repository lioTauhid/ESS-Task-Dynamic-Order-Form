import 'package:flutter/material.dart';
import '../../../utils/utils.dart';
import '../constants/app_color.dart';

Future<void> showCustomDialog(BuildContext context, String title, Widget widget,
    int heightReduce, int widthReduce) async {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          // backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width - widthReduce,
            height: MediaQuery.of(context).size.height - heightReduce,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.secondaryBackground,
            ),
            child: Column(
              children: [
                dialogHeader(title, context),
                Divider(color: AppColor.textSecondary, thickness: 1),
                const SizedBox(height: 10),
                Expanded(
                  child: widget,
                ),
              ],
            ),
          ));
    },
  );
}

Widget dialogHeader(String title, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColor.textPrimary),
        ),
        IconButton(
          onPressed: () {
            Utils.hidePopup();
          },
          icon: Icon(
            Icons.close,
            color: AppColor.textSecondary,
          ),
        ),
      ],
    ),
  );
}
