import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/container_placeholder.dart';
import 'package:kabanas_barbershop/components/custom_alert_dialog.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_text_button.dart';
import 'package:kabanas_barbershop/components/hour_component.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/bloc/employee_hours_bloc.dart';
import 'package:kabanas_barbershop/screens/calendar_employee/calendar/calendar_module.dart';

class CalendarPage extends StatefulWidget {

  final String month;
  final UserModel employee;
  final int weekDayNumber;
  final DateTime dayOfWeek;
  const CalendarPage({Key key, this.month, this.employee,this.weekDayNumber, this.dayOfWeek}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  var dateBloc = AppModule.to.getBloc<DateBloc>();
  var hourBloc = AppModule.to.getBloc<HourBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var employeeHourBloc = CalendarModule.to.getBloc<EmployeeHoursBloc>();

  @override
  void initState() {
    if (dateBloc.weekDay != 7) {
      employeeHourBloc.getListOfHoursByEmployeeId(widget.employee.id, widget.weekDayNumber);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('${widget.dayOfWeek.day}/${widget.dayOfWeek.month}/${widget.dayOfWeek.year}', style: enterpriseText,),
          dateBloc.weekDay == widget.weekDayNumber ? Padding(
            padding: const EdgeInsets.only(top: 10,left: 10),
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
                      style: enterpriseText,
                    );
                  }
                }),
          ) : Container(),
          StreamBuilder<List<HourModel>>(
            initialData: [],
            stream: employeeHourBloc.hoursByEmployeeId,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Text('nao tem anda aqui'),
                  );
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
                                                    'Deseja reservar o horário das ${hourModel.hour} do dia ${widget.dayOfWeek.day}/${widget.dayOfWeek.month}/${widget.dayOfWeek.year}',
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
                                                            int weekDay = await dateBloc.getWeekDay();
                                                            if(!checkDateTimeFormatted(hourModel.hour) && widget.weekDayNumber ==  weekDay) {
                                                              print('erro');
                                                              ToastUtilsFail
                                                                  .showCustomToast(
                                                                  context,
                                                                  'Não é possível registrar esse horário');
                                                            } else {
                                                              await employeeHourBloc.createRegisterInEmployeeHourColletion(
                                                                timeStamp: widget.dayOfWeek,
                                                                userModel: userBloc.user,
                                                                hourModel: hourModel,
                                                                context: context,
                                                                oneSignalId: widget.employee.oneSignalId,
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
          SizedBox(
            height: 400,
          ),
        ],
      ),
    );
  }
}
