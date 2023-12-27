import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';

class TextFieldEditProductWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String value;
  final String title;
  final String? initialValue;
  final String? hintText;
  final String? Function(String?)? onValidator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const TextFieldEditProductWidget({
    super.key,
    required this.controller,
    required this.value,
    required this.title,
    this.hintText,
    this.initialValue,
    this.readOnly = false,
    this.onValidator,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(title),
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          readonly: readOnly,
          controller: controller,
          initialValue: initialValue,
          hintText: hintText,
          onValidator: onValidator,
          textErrorColor: Theme.of(context).colorScheme.error,
        ),
      ],
    );
  }
}
