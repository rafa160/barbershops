import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class DropBoxContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedContainer(
      verticalOffset: 10,
      horizontalOffset: 120,
      milliseconds: 1200,
      position: 6,
      widget: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.075,
              padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ]),
              child: Center(
                child: FormBuilderDropdown(
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.certificate,
                      size: 20,
                      color: Colors.grey[300],
                    ),
                    errorStyle:
                        TextStyle(fontSize: 10, color: Colors.redAccent),
                    counterText: '',
                    hintStyle: textFormCard,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  isExpanded: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  hint: Text(
                    'Tipo',
                    style: enterpriseCardText,
                  ),
                  name: 'category',
                  items: [
                    'Cabelo Fem.',
                    'Cabelo Masc.',
                    'Depiladora Fem.',
                    'Depiladora Masc.',
                    'Manicure',
                    'Manicure e Pedicure',
                    'Maquiagem',
                    'Pedicure',
                    'Sobrancelhas',
                  ].map((e) {
                    return DropdownMenuItem(
                      child: Text(
                        '$e',
                        style: textFormCard,
                      ),
                      value: e,
                    );
                  }).toList(growable: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
