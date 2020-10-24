import 'package:flutter/material.dart';
import '../../base/base.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.textEditingController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      controller: textEditingController,
      cursorColor: context.colorScheme.primary,
      focusNode: focusNode,
      style: TextStyle(
        color: context.colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        filled: true,
        labelStyle: TextStyle(color: context.colorScheme.onPrimary),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: context.colorScheme.onPrimary),
        ),
        labelText: hintText,
        hintStyle: TextStyle(color: context.colorScheme.primary, fontSize: 14),
        prefixIcon: Icon(
          prefixIconData,
          size: 20,
          color: context.colorScheme.onPrimary,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            suffixIconData,
            size: 20,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
