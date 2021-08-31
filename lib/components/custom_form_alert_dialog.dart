import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:kabanas_barbershop/bloc/price_bloc.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/price_model.dart';
import 'package:kabanas_barbershop/screens/admin/services/services_module.dart';
import 'custom_text_button.dart';

class CustomFormAlertDialog extends StatelessWidget {

  final PriceModel price;
  final String text;
  final Widget widget;
  final int number;

  const CustomFormAlertDialog({Key key, this.price, this.text, this.widget, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
    var priceBloc = ServicesModule.to.getBloc<PriceBloc>();

    return  price != null ? AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        text,
        style: alertDialogTextTitle,
      ),
      content: FormBuilder(
        key: _formKey,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomFormField(
                text: 'description',
                hint: 'Descrição',
                initialValue: price.description ?? '',
                enabled: number == 1 ? true : false,
                action: TextInputAction.next,
                type: TextInputType.name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                obscureText: false,
                maxLines: 1,
              ),
              CustomFormField(
                text: 'price',
                hint: 'Valor',
                initialValue: price.price ?? '',
                enabled: number == 1 ? true : false,
                action: TextInputAction.next,
                type: TextInputType.number,
                input: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                maxLength: 3,
                obscureText: false,
                maxLines: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: number == 1 ? CustomButton(
                  widget: Text('editar', style: buttonColors,),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                                await priceBloc.editPriceModel(
                                    context: context,
                                    price: _formKey.currentState.value['price'],
                                    description: _formKey
                                        .currentState.value['description'],
                                    priceId: price.id);
                              }
                            },
                ) : CustomButton(
                  widget: Text('deletar', style: buttonColors,),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await priceBloc.deletePriceModel(id: price.id, context: context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
    ) : AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        text,
        style: alertDialogTextTitle,
      ),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              text: 'description',
              hint: 'Descrição',
              initialValue: '',
              enabled: true,
              action: TextInputAction.next,
              type: TextInputType.name,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
              obscureText: false,
              maxLines: 1,
            ),
            CustomFormField(
              text: 'price',
              hint: 'Valor',
              initialValue: '',
              enabled: true,
              action: TextInputAction.next,
              type: TextInputType.number,
              input: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 3,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
              obscureText: false,
              maxLines: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: CustomButton(
                widget: Text('criar', style: buttonColors,),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await priceBloc.createPriceModel(
                        context: context,
                        price: _formKey.currentState.value['price'],
                        description: _formKey
                            .currentState.value['description'],);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
