import 'package:brasil_fields/brasil_fields.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/category_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/components/drop_box_container.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/admin/register_employee/register_employee_module.dart';

class RegisterEmployeePage extends StatefulWidget {
  @override
  _RegisterEmployeePageState createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var hourBloc = AppModule.to.getBloc<HourBloc>();
  var categoryBloc = RegisterEmployeeModule.to.getBloc<CategoryBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Cadastrar Funcionário',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CustomAnimatedContainer(
                      verticalOffset: 10,
                      horizontalOffset: 120,
                      milliseconds: 1200,
                      position: 2,
                      widget: Text(
                        'Cadastre seu funcionário', style: enterpriseText,
                      ),
                    ),
                  ),
                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 3,
                    widget: CustomFormField(
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
                  ),

                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 3,
                    widget: CustomFormField(
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
                  ),
                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 4,
                    widget: CustomFormField(
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
                  ),
                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 5,
                    widget: CustomFormField(
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
                  ),
                  DropBoxContainer(),
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
                                List<HourModel> list = await hourBloc.getListOfHoursFromTheStreamList();
                                await userBloc.signUpWithEmailPasswordAdminPastor(
                                    context: context,
                                    email: _formKey.currentState.value['email'],
                                    password: _formKey.currentState.value['password'],
                                    name: _formKey.currentState.value['name'],
                                    phone: _formKey.currentState.value['whats_app'],
                                    hoursList: list,
                                    categoryName: _formKey.currentState.value['category']
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
          ),
        ),
      ),
    );
  }
}
