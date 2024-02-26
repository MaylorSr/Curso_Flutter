import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;

  final String? hint;

  final String? errorMessage;

  final bool obscure;

  final Function(String?)? onchange;

  final String? Function(String?)? validator;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.onchange,
      this.validator,
      this.obscure = false});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      //*borderSide: BorderSide(color: color.primary),
      borderRadius: BorderRadius.circular(
        20,
      ),
    );

    /*  final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color.error)
    ); */

    return TextFormField(
      onChanged: onchange,
      validator: validator,
      obscureText: obscure!,
      decoration: InputDecoration(
        enabledBorder: border,
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: color.primary,
        icon: Icon(Icons.person_2_rounded, color: color.primary),
        prefixIcon: Icon(Icons.supervised_user_circle_outlined),
        suffixIcon: Icon(Icons.check),
        errorText: errorMessage,
        focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(
          color: color.error,
        )),
        errorBorder: border.copyWith(
            borderSide: BorderSide(
          color: color.error,
        )),
        focusedBorder: border.copyWith(
            borderSide: BorderSide(
          color: color.primary,
        )),
      ),
    );
  }
}
