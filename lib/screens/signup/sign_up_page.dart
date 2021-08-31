import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Cadastrar',
        ),
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                CustomFormField(
                  icon: FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                    size: 20,
                    color: Colors.grey[300],
                  ),
                  text: 'email',
                  hint: 'E-mail',
                  initialValue: '',
                  enabled: true,
                  action: TextInputAction.next,
                  type: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.email(context),
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: false,
                  maxLines: 1,
                ),
                CustomFormField(
                  icon: FaIcon(
                    FontAwesomeIcons.signature,
                    size: 20,
                    color: Colors.grey[300],
                  ),
                  text: 'name',
                  hint: 'Nome e Sobrenome',
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
                  icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    size: 20,
                    color: Colors.grey[300],
                  ),
                  text: 'whats_app',
                  hint: 'WhatsApp',
                  initialValue: '',
                  enabled: true,
                  input: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  action: TextInputAction.next,
                  type: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: false,
                  maxLines: 1,
                ),
                CustomFormField(
                  icon: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Colors.grey[300],
                  ),
                  text: 'password',
                  hint: 'Senha',
                  initialValue: '',
                  enabled: true,
                  action: TextInputAction.send,
                  type: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  obscureText: true,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: StreamBuilder(
                    initialData: [],
                    stream: userBloc.loginStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != true) {
                        return CustomButton(
                          widget: Text('finalizar cadastro', style: subTitlePlanCard,),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await userBloc.signUp(
                                context: context,
                                email: _formKey.currentState.value['email'],
                                password: _formKey.currentState.value['password'],
                                name: _formKey.currentState.value['name'],
                                phone: _formKey.currentState.value['whats_app'],
                                admin: false,
                                available: true,
                                status: 2
                              );
                            }
                          },
                        );
                      } else {
                        return CustomButton(
                          onPressed: () {},
                          widget: CustomColorCircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
