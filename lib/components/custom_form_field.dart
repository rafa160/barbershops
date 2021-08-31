import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class CustomFormField extends StatelessWidget {

  final String text;
  final TextInputAction action;
  final TextInputType type;
  final bool obscureText;
  final String hint;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> input;
  final String initialValue;
  final Function onChanged;
  final int maxLength;
  final FocusNode focusNode;
  final ValueTransformer transformer;
  final int maxLines;
  final TextEditingController controller;
  final FaIcon icon;

  const CustomFormField({Key key, this.text, this.action, this.type, this.obscureText, this.hint, this.enabled, this.validator, this.input, this.initialValue, this.onChanged, this.maxLength, this.focusNode, this.transformer, this.maxLines, this.controller, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30,left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.075,
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10
                ),
              ]
            ),
            child: Center(
              child: FormBuilderTextField(
                controller: controller,
                maxLines: maxLines,
                focusNode: focusNode,
                style: textFormCard,
                onChanged: onChanged,
                enabled: enabled,
                initialValue: initialValue,
                name: text,
                autocorrect: false,
                validator: validator,
                textInputAction: action,
                keyboardType: type,
                obscureText: obscureText,
                maxLength: maxLength,
                inputFormatters: input,
                valueTransformer: transformer,
                decoration: InputDecoration(
                  icon: icon,
                  errorStyle: TextStyle(fontSize: 10, color: Colors.redAccent),
                  counterText: '',
                  hintText: hint,
                  hintStyle: enterpriseCardText,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
