import 'package:flutter/material.dart';
import '../../provider/i18n_provider.dart';

class NotPermissionDialog extends StatefulWidget {
  const NotPermissionDialog(this.provider);

  final I18NPermissionProvider provider;

  @override
  _NotPermissionDialogState createState() => _NotPermissionDialogState();
}

class _NotPermissionDialogState extends State<NotPermissionDialog> {
  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    return AlertDialog(
      title: Text(provider.titleText),
      actions: <Widget>[
        TextButton(
          onPressed: _onCancel,
          child: Text(provider.cancelText),
        ),
        TextButton(
          onPressed: _onSure,
          child: Text(provider.sureText),
        ),
      ],
    );
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onSure() {
    Navigator.pop(context, true);
  }
}
