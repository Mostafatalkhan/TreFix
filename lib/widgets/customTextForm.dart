import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(
      {required this.hint,
      super.key,
      required this.controller,
      this.fun,
      this.type,
      this.icon,
      this.secure});

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? fun;
  final TextInputType? type;
  final Icon? icon;
  final bool? secure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      validator: fun ??
          (value) {
            if (controller.text.isEmpty) {
              return 'Field Mustn`t Be Empty';
            }
            return null;
          },
      obscureText: secure ?? false,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: const BorderSide(color: Colors.redAccent)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24))),
    );
  }
}
