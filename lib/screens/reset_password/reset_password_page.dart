import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/colored_custom_container.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            CustomAnimatedContainer(
              milliseconds: 1550,
              horizontalOffset: 150,
              position: 1,
              widget: ColoredCustomContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FaIcon(
                        FontAwesomeIcons.lock,
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
                              Text(
                                'Atualizar Senha',
                                style: appBarTitle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 60,
            ),
            CustomAnimatedContainer(
              milliseconds: 1200,
              horizontalOffset: -200,
              position: 3,
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
                            widget: Text('enviar', style: buttonColors,),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await userBloc.resetPassword(
                                    _formKey.currentState.value['email'],
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
          ],
        ),
      ),
    );
  }
}
