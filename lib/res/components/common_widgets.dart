import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/value.dart';

Widget iconTextBtn(
    dynamic image, String text, Color bg, Color txtColor, double font,
    {Function()? onPressed}) {
  return MaterialButton(
    elevation: 0,
    color: bg,
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        image,
        const SizedBox(width: 5),
        Text(text, style: TextStyle(color: txtColor, fontSize: font)),
      ],
    ),
  );
}

Widget normalButton(
    String text, Color background, Color textColor, double fontSize,
    {Function()? onPressed}) {
  return MaterialButton(
      elevation: 0,
      color: background,
      padding: const EdgeInsets.all(10),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(400.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ));
}

Widget normalTextField(TextEditingController controller, String hint,
    {prefIcon}) {
  return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: Values.fontSmall, color: AppColor.textPrimary),
      decoration: InputDecoration(
        fillColor: AppColor.secondaryBackground,
        prefixIcon: prefIcon,
        hintText: hint,
        hintStyle:
            TextStyle(fontSize: Values.fontSmall, color: AppColor.textPrimary),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor.textPrimary)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.primaryColor)),
      ));
}
