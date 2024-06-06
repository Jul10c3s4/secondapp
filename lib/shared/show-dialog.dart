import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';

class ShowAlertDialog {
  static buildDialog(
      BuildContext context, String title, Widget content, Function clickOk) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: CustomTitle.buildTitle(context, title),
            content: content,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomTitle.buildCancelTitle(context, "Cancelar")),
              TextButton(
                  onPressed: () {
                    clickOk();
                  },
                  child: CustomTitle.buildOkTitle(context, "Ok"))
            ],
          );
        });
  }

  static buildDialogOk(BuildContext context, String title) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: CustomTitle.buildTitle(context, title),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CustomTitle.buildOkTitle(context, "Ok"))
            ],
          );
        });
  }
}
