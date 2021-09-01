import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/one_signal_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/colored_custom_container.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/screens/reset_password/reset_password_module.dart';
import 'package:kabanas_barbershop/screens/signup/sign_up_module.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var oneSignalBloc = AppModule.to.getBloc<OneSignalBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: 200,
                  position: 1,
                  widget: Hero(
                    tag: 'logo',
                    child: ColoredCustomContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          FaIcon(
                            FontAwesomeIcons.meteor,
                            size: 70,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Login', style: appBarTitle,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1200,
                  horizontalOffset: -200,
                  position: 2,
                  widget:CustomFormField(
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
                  milliseconds: 1200,
                  horizontalOffset: -200,
                  position: 3,
                  widget:CustomFormField(
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
                CustomAnimatedContainer(
                    milliseconds: 1200,
                    horizontalOffset: -200,
                    position: 4,
                    widget: Padding(
                    padding: const EdgeInsets.only(top: 12,left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(() => ResetPasswordModule());
                            },
                            child: Text(
                              'esqueceu sua senha?',
                              style: titleForms,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                CustomAnimatedContainer(
                    milliseconds: 1200,
                    horizontalOffset: -200,
                    position: 5,
                    widget:Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StreamBuilder(
                        stream: userBloc.loginStream,
                        initialData: [],
                        builder: (context, snapshot) {
                          if(snapshot.data != true) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: CustomButton(
                                widget: Text('Entrar', style: buttonColors,),
                                onPressed: () async {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    await userBloc.signIn(
                                        _formKey.currentState.value['email'],
                                        _formKey.currentState.value['password'],
                                        context);
                                  }
                                },
                              ),
                            );
                          } else {
                            return CustomButton(
                              onPressed: () {},
                              widget: CustomColorCircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                    milliseconds: 1200,
                    horizontalOffset: -200,
                    position: 6,
                    widget:Padding(
                    padding: const EdgeInsets.only(top: 12,left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Não tem uma conta? ',style: titleForms,),
                        GestureDetector(
                            onTap: () {
                              Get.to(() => SignUpModule());
                            },
                            child: Text(
                              'Cadastre-se',
                              style: titleColoredForms,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
