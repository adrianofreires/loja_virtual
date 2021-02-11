import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final String title;
  final bool bold;
  final String hint;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final int maxLength;
  final TextAlign textAlign;
  final FocusNode focusNode;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;

  CardTextField(
      {this.title,
      this.hint,
      this.bold = false,
      this.textInputType,
      this.inputFormatters,
      this.textAlign = TextAlign.start,
      this.validator,
      this.focusNode,
      this.onSubmitted,
      this.maxLength})
      : textInputAction = onSubmitted == null ? TextInputAction.done : TextInputAction.next;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        initialValue: '',
        validator: validator,
        builder: (state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                      if (state.hasError)
                        Text(
                          '    Inválido',
                          style: TextStyle(color: Colors.red, fontSize: 9.0),
                        ),
                    ],
                  ),
                TextFormField(
                  style: TextStyle(
                      color: title == null && state.hasError ? Colors.red : Colors.white,
                      fontWeight: bold ? FontWeight.bold : FontWeight.w400),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle:
                        TextStyle(color: title == null && state.hasError ? Colors.red : Colors.white.withAlpha(100)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    counterText: '',
                  ),
                  keyboardType: textInputType,
                  inputFormatters: inputFormatters,
                  onChanged: (text) {
                    state.didChange(text);
                  },
                  maxLength: maxLength,
                  textAlign: textAlign,
                  focusNode: focusNode,
                  onFieldSubmitted: onSubmitted,
                  textInputAction: textInputAction,
                ),
              ],
            ),
          );
        });
  }
}
