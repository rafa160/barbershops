import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/components/custom_alert_dialog.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_text_button.dart';
import 'package:kabanas_barbershop/components/hour_component.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/bloc/employee_profile_bloc.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_hours/employee_hours_module.dart';

class EmployeeHoursPage extends StatefulWidget {
  final UserModel userModel;

  const EmployeeHoursPage({Key key, this.userModel}) : super(key: key);

  @override
  _EmployeeHoursPageState createState() => _EmployeeHoursPageState();
}

class _EmployeeHoursPageState extends State<EmployeeHoursPage> {
  var employeeProfileBloc =
      EmployeeHoursModule.to.getBloc<EmployeeProfileBloc>();

  @override
  void initState() {
    employeeProfileBloc.employeeId = widget.userModel.id;
    employeeProfileBloc.getEmployeeHoursStreamListById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Gerencie seus horários',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 1,
                  widget: Text(
                    'Aqui é possível retirar os horários que não fazem parte da sua jornada de trabalho ou atualizar o horário caso exista um cancelaento.',
                    style: subtitleMonthPageStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 20),
                child: CustomAnimatedContainer(
                  milliseconds: 1000,
                  horizontalOffset: -200,
                  position: 2,
                  widget: Text(
                    'Por favor, notar que a retirada de um horário não é possível adicioar novamente nessa atual versão.',
                    style: alertDialogSubtitleText,
                  ),
                ),
              ),
              StreamBuilder<List<HourModel>>(
                stream: employeeProfileBloc.hoursByEmployeeId,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CustomColorCircularProgressIndicator();
                    default:
                  }
                  return AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        HourModel hourModel = snapshot.data[index];
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1550),
                            child: SlideAnimation(
                              verticalOffset: 230,
                              child: FadeInAnimation(
                                child: HourComponent(
                                    hourModel: hourModel,
                                    index: 1,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialog(
                                              title:
                                                  'Deseja retirar esse horário da sua agenda?',
                                              content:
                                                  'Por Favor só confirme se realmente estiver certo. Retirando esse horário o mesmo não existira na sua agenda!',
                                              no: () {
                                                Get.back();
                                              },
                                              widget: CustomTextButton(
                                                text: 'sim',
                                                onPressed: () async {
                                                  await employeeProfileBloc.deleteEmployeeHour(hourModel: hourModel, context: context);
                                                  print('deletando ${hourModel.id}- ${hourModel.hour}');
                                                },
                                              ),
                                            );
                                          });
                                    },
                                  onLongPress: () async {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomAlertDialog(
                                            title:
                                            'Esse horário foi cancelado?',
                                            content:
                                            'Atualizando esse horário ele ficará disponível para agendamento.',
                                            no: () {
                                              Get.back();
                                            },
                                            widget: CustomTextButton(
                                              text: 'sim',
                                              onPressed: () async {
                                                await employeeProfileBloc
                                                    .updateTheHourForTrue(id: hourModel.id, context: context);
                                              },
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
