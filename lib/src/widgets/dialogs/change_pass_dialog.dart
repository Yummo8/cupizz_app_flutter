import 'package:cupizz_app/src/base/base.dart';

class ChangePassDialog {
  static Future show(
    BuildContext context, {
    String? avatar,
    String? nickName,
    bool requireOldPass = false,
    Future Function(String oldPass, String newPass)? onSend,
    bool? isLoading,
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
                Text(
                  'Đổi mật khẩu',
                  style: context.textTheme.headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
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
                ] else if (nickName.isExistAndNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CustomNetworkImage(
                          avatar ?? '',
                          isAvatar: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(nickName ?? '',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ))
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
                TextFieldWidget(
                  hintText: Strings.common.newPassword,
                  obscureText: true,
                  prefixIconData: Icons.lock,
                  textEditingController: newPassword,
                  validator: (v) {
                    if (newPassword.text == oldPassword.text) {
                      return 'Mật khẩu mới phải khác mật khẩu cũ';
                    }
                    return Validator.password(v);
                  },
                  textColor: context.colorScheme.onBackground,
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  hintText: 'Nhập lại mật khẩu',
                  obscureText: true,
                  prefixIconData: Icons.lock,
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
                    text: Strings.button.save,
                    width: 120,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        if (onSend != null) {
                          await onSend(oldPassword.text, newPassword.text);
                        }
                        Navigator.pop(context);
                      }
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
