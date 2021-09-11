import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
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
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/bloc/employee_profile_bloc.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_hours/employee_hours_module.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_profile_module.dart';
import 'package:url_launcher/url_launcher.dart';


class EmployeeProfilePage extends StatefulWidget {

  final UserModel userModel;

  const EmployeeProfilePage({Key key, this.userModel}) : super(key: key);

  @override
  _EmployeeProfilePageState createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {

  var dateBloc = AppModule.to.getBloc<DateBloc>();
  var employeeProfileBloc = EmployeeProfileModule.to.getBloc<EmployeeProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Área do Funcionário',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimatedContainer(
                  milliseconds: 800,
                  horizontalOffset: 100,
                  position: 1,
                  widget: StreamBuilder(
                    initialData: [],
                    stream: dateBloc.streamTomorrowDay,
                    builder: (context, snapshot) {
                      if (snapshot.data.isEmpty) {
                        return ContainerPlaceholder(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          lines: 1,
                        );
                      } else {
                        return Text( 'Atualizar lista para o próximo dia ${snapshot.data}?',
                          style: subtitleMonthPageStyle,);
                      }
                    },
                  ),
                ),
                CustomAnimatedContainer(
                  milliseconds: 800,
                  horizontalOffset: 100,
                  position: 2,
                  widget: Text(
                    'Fique atento, clicando nesse botão irá atualizar sua lista, então só faça essa ação ao final do dia para não perder a agenda do dia atual.',
                    style: alertDialogSubtitleText,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                    milliseconds: 800,
                    horizontalOffset: 100,
                    position: 3,
                    widget: StreamBuilder(
                      initialData: [],
                      stream: employeeProfileBloc.loadingStream,
                      builder: (context, snapshot) {
                        if(snapshot.data != true) {
                          return CustomButton(
                            widget: Text('atualizar', style: buttonColors,),
                            onPressed: () async {
                              employeeProfileBloc.updateHoursAvailability(context: context, id: widget.userModel.id);
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
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 800,
                  horizontalOffset: 100,
                  position: 4,
                  widget: Text('Gerenciamento de horário',style: subtitleMonthPageStyle,),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                  milliseconds: 800,
                  horizontalOffset: 100,
                  position: 5,
                  widget: StreamBuilder(
                    initialData: [],
                    stream: employeeProfileBloc.loadingStream,
                    builder: (context, snapshot) {
                      if(snapshot.data != true) {
                        return CustomButton(
                          widget: Text('gerenciar horários', style: buttonColors,),
                          onPressed: () async {
                            await Get.to(() => EmployeeHoursModule(widget.userModel));
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
                SizedBox(
                  height: 20,
                ),
                CustomAnimatedContainer(
                    milliseconds: 800,
                    horizontalOffset: -200,
                    position: 6,
                    widget: StreamBuilder(
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
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: employeeProfileBloc.getAdminRegisterList(widget.userModel.id),
                  builder: (context, snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                    }
                    return AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: employeeProfileBloc.employeeRegisterList.length,
                        itemBuilder: (context, index) {
                          RegisterModel register = snapshot.data[index];
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1550),
                              child: SlideAnimation(
                                horizontalOffset: 120,
                                child: FadeInAnimation(
                                  child: NewCardClientInfo(
                                    register: register,
                                  ),
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
