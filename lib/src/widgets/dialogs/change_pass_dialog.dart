part of '../index.dart';

class ChangePassDialog {
  static Future show(
    BuildContext context, {
    String avatar,
    String nickName,
    bool requireOldPass = false,
    Future Function(String oldPass, String newPass) onSend,
    bool isLoading,
  }) async {
    final oldPassword = TextEditingController(text: '');
    final newPassword = TextEditingController(text: '');
    final formKey = GlobalKey<FormState>();
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Form(
            key: formKey,
            child: ListView(
              itemExtent: null,
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                if (requireOldPass) ...[
                  TextFieldWidget(
                    hintText: Strings.common.oldPassword,
                    obscureText: true,
                    prefixIconData: Icons.lock,
                    textEditingController: oldPassword,
                    validator: Validator.password,
                    textColor: context.colorScheme.onBackground,
                  ),
                  const SizedBox(height: 15),
                ],
                TextFieldWidget(
                  hintText: Strings.common.newPassword,
                  obscureText: true,
                  prefixIconData: Icons.lock,
                  textEditingController: newPassword,
                  validator: Validator.password,
                  textColor: context.colorScheme.onBackground,
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  hintText: 'Nhập lại mật khẩu mới',
                  obscureText: true,
                  prefixIconData: Icons.lock,
                  textEditingController: oldPassword,
                  textColor: context.colorScheme.onBackground,
                  validator: (v) {
                    if (v != newPassword.text) {
                      return 'Mật khẩu không khớp';
                    }
                    return Validator.password(v);
                  },
                ),
                const SizedBox(height: 25),
                Align(
                  child: SmallAnimButton(
                    text: 'Đổi mật khẩu',
                    width: 120,
                    onPressed: () async {
                      if (onSend != null) {
                        await onSend(oldPassword.text, newPassword.text);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
