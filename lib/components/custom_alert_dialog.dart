import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'custom_text_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget widget;
  final VoidCallback yes;
  final VoidCallback no;

  const CustomAlertDialog({Key key, this.title, this.content, this.no, this.yes, this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        title,
        style: alertDialogTextTitle,
      ),
      content: Text(
        content,
        style: alertDialogSubtitleText,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomTextButton(
              text: 'não',
              onPressed: no,
            ),
            widget
          ],
        )
      ],
    );
  }
}
