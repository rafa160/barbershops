import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/register_bloc.dart';
import 'package:kabanas_barbershop/components/container_placeholder.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_cupertino_card.dart';
import 'package:kabanas_barbershop/components/new_card_client_info.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/register_model.dart';
import 'package:kabanas_barbershop/screens/admin/admin_module.dart';
import 'package:kabanas_barbershop/screens/admin/register_employee/register_employee_module.dart';
import 'package:kabanas_barbershop/screens/admin/services/services_module.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  var dateBloc = AppModule.to.getBloc<DateBloc>();
  var hourBloc = AdminModule.to.getBloc<HourBloc>();
  var registerBloc = AdminModule.to.getBloc<RegisterBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Área do Administrador',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 1,
                  widget: Text(
                    'Cadastre e edite serviços',
                    style: subtitleMonthPageStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 2,
                  widget: CustomButton(
                    widget: Text(
                      'cadastrar serviços',
                      style: buttonColors,
                    ),
                    onPressed: () async {
                      Get.to(() => ServicesModule());
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 2,
                  widget: Text('Cadastrar novo Funcionário', style: subtitleMonthPageStyle,),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 2,
                  widget:                 CustomButton(
                    widget: Text('cadastar', style: buttonColors,),
                    onPressed: () async {
                      await Get.to(() => RegisterEmployeeModule());
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  initialData: [],
                  stream: dateBloc.streamActualDay,
                  builder: (context, snapshot) {
                    if (snapshot.data.isEmpty) {
                      return ContainerPlaceholder(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        lines: 1,
                      );
                    } else {
                      return Text( 'Esses são os horários do dia ${snapshot.data}.',
                        style: subtitleMonthPageStyle,);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: registerBloc.getAdminRegisterList(),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CustomColorCircularProgressIndicator();
                      default:
                    }
                    return AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: registerBloc.adminRegisterList.length,
                        itemBuilder: (context, index) {
                          RegisterModel register = snapshot.data[index];
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1550),
                              child: SlideAnimation(
                                horizontalOffset: 120,
                                child: FadeInAnimation(
                                  child: NewCardClientInfo(
                                    register: register
                                  )
                                ),
                              )
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
