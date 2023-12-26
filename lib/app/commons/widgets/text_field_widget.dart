import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? onValidator;

  final bool readonly;
  final bool obscureText;
  final void Function()? onTap;

  const TextFieldWidget({
    super.key,
    this.hintText,
    this.initialValue,
    this.controller,
    this.prefixIcon,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.onValidator,
    this.obscureText = false,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      controller: controller,
      readOnly: readonly,
      onTap: onTap,
      validator: onValidator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        prefixIconConstraints: const BoxConstraints(minWidth: 40),

        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: prefixIcon,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: suffixIcon,
              )
            : null,
        fillColor: Theme.of(context)
            .colorScheme
            .onPrimary, // Defina a cor de fundo desejada
        hintText: hintText,
        labelText: initialValue,

        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),

        errorStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.errorContainer),

        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Theme.of(context).colorScheme.error),
          borderRadius: BorderRadius.circular(20),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20), // Define o raio da borda
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20), // Define o raio da borda
        ),
      ),
    );
  }
}
