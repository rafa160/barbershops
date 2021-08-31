import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/container_placeholder.dart';
import 'package:kabanas_barbershop/components/custom_alert_dialog.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_text_button.dart';
import 'package:kabanas_barbershop/components/hour_component.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/bloc/employee_hours_bloc.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar_employee_module.dart';

class CalendarEmployeePage extends StatefulWidget {
  final String month;
  final UserModel employee;

  const CalendarEmployeePage({Key key, this.month, this.employee})
      : super(key: key);

  @override
  _CalendarEmployeePageState createState() => _CalendarEmployeePageState();
}

class _CalendarEmployeePageState extends State<CalendarEmployeePage> {

  var dateBloc = CalendarEmployeeModule.to.getBloc<DateBloc>();
  var hourBloc = AppModule.to.getBloc<HourBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var employeeHourBloc = CalendarEmployeeModule.to.getBloc<EmployeeHoursBloc>();

  @override
  void initState() {
    dateBloc.getMessageForEachDay();
    if (dateBloc.weekDay != 7) {
      employeeHourBloc.getListOfHoursByEmployeeId(widget.employee.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Agenda de ${widget.month} - ${widget.employee.name}',
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StreamBuilder(
                      initialData: [],
                      stream: dateBloc.streamActualDay,
                      builder: (context, snapshot) {
                        if (snapshot.data.isEmpty) {
                          return ContainerPlaceholder(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.06,
                            lines: 1,
                          );
                        } else {
                          return Text(
                            '${snapshot.data.toString()}',
                            style: enterpriseText,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: StreamBuilder(
                    initialData: [],
                    stream: dateBloc.streamMessage,
                    builder: (context, snapshot) {
                      if (snapshot.data.isEmpty) {
                        return ContainerPlaceholder(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          lines: 1,
                        );
                      } else {
                        return Text(
                          '${snapshot.data}',
                          style: subtitleMonthPageStyle,
                        );
                      }
                    }),
              ),
              StreamBuilder<List<HourModel>>(
                initialData: [],
                stream: employeeHourBloc.hoursByEmployeeId,
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
                                    onTap: hourModel.available == true
                                        ? () {
                                            print(
                                                'entrou no horario ${hourModel.hour}');
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CustomAlertDialog(
                                                    title:
                                                        'Deseja reservar o horário das ${hourModel.hour}',
                                                    content:
                                                        'Por Favor só confirme se realmente estiver certo. Reservando esse horário e não comparecer estará deixando outra pessoa sem a vaga.',
                                                    no: () {
                                                      Get.back();
                                                    },
                                                    widget: StreamBuilder(
                                                      initialData: [],
                                                      stream: hourBloc
                                                          .loadingStream,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.data !=
                                                            true) {
                                                          return CustomTextButton(
                                                              text: 'sim',
                                                              onPressed: () async{
                                                                employeeHourBloc.hourId = hourModel.id;
                                                                if(!checkDateTimeFormatted(hourModel.hour)) {
                                                                  print('erro');
                                                                  ToastUtilsFail
                                                                      .showCustomToast(
                                                                      context,
                                                                      'Não é possível registrar esse horário');
                                                                } else {
                                                                  await employeeHourBloc.createRegisterInEmployeeHourColletion(
                                                                    userModel: userBloc.user,
                                                                    hourModel: hourModel,
                                                                    context: context,
                                                                    oneSignalId: widget.employee.oneSignalId
                                                                  );
                                                                  Get.back();
                                                                  ToastUtilsSuccess
                                                                      .showCustomToast(
                                                                      context,
                                                                      'Pronto, agora é com você! te esperamos no horário');
                                                                }
                                                              });
                                                        } else {
                                                          return Center(
                                                            child: SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  );
                                                });
                                          }
                                        : () {
                                            ToastUtilsFail.showCustomToast(
                                                context,
                                                'Horário já reservado');
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
