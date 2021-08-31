import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/hour_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/container_placeholder.dart';
import 'package:kabanas_barbershop/components/custom_alert_dialog.dart';
import 'package:kabanas_barbershop/components/custom_animation_toast.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_text_button.dart';
import 'package:kabanas_barbershop/components/hour_component.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/hour_model.dart';
import 'package:kabanas_barbershop/screens/month/month_module.dart';

class MonthPage extends StatefulWidget {

  final String month;

  const MonthPage({Key key, this.month}) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {

  var dateBloc = MonthModule.to.getBloc<DateBloc>();
  var hourBloc = AppModule.to.getBloc<HourBloc>();
  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  void initState() {
    dateBloc.getMessageForEachDay();
    if(dateBloc.weekDay != 7){
      hourBloc.getListOfHours();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Agenda de ${widget.month}',
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8,right: 8),
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: StreamBuilder(
                    initialData:[],
                    stream: dateBloc.streamMessage,
                    builder: (context, snapshot) {
                      if (snapshot.data.isEmpty) {
                        return ContainerPlaceholder(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                          lines: 1,
                        );
                      } else {
                        return Text('${snapshot.data}', style: subtitleMonthPageStyle,);
                      }
                    }
                  ),
                ),
                dateBloc.weekDay != 7 ?
                StreamBuilder<List<HourModel>>(
                  initialData: [],
                  stream: hourBloc.hours,
                  builder: (context, snapshot) {
                    if(snapshot.data.length < 0) {
                      return CircularProgressIndicator();
                    } else {
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
                                verticalOffset: 150,
                                child: FadeInAnimation(
                                  child: HourComponent(
                                    hourModel: hourModel,
                                    onTap: hourModel.available == true ? () {
                                      print('entrou no horario ${hourModel.hour}');
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomAlertDialog(
                                              title: 'Deseja reservar o horário das ${hourModel.hour}',
                                              content: 'Por Favor só confirme se realmente estiver certo. Reservando esse horário e não comparecer estará deixando outra pessoa sem a vaga.',
                                              no: () {
                                                Get.back();
                                              },
                                              widget: StreamBuilder(
                                                initialData: [],
                                                stream: hourBloc.loadingStream,
                                                builder: (context, snapshot) {
                                                  if(snapshot.data != true) {
                                                    return CustomTextButton(
                                                        text: 'sim',
                                                        onPressed: () {
                                                          hourBloc.hourId = hourModel.id;
                                                          hourBloc.createHourRegister(
                                                              userModel: userBloc.user,
                                                              hourId: hourBloc.hourId,
                                                              hourModel: hourModel
                                                          );
                                                          Get.back();
                                                          ToastUtilsSuccess.showCustomToast(context, 'Pronto, agora é com você! te esperamos no horário');
                                                          print('updating');
                                                        }
                                                    );
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
                                          }
                                      );
                                    } : (){
                                      ToastUtilsFail.showCustomToast(context, 'Horário já reservado');
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ) : Center(
                  child: Container(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.ghost,
                          size: 120,
                          color: Colors.deepOrange[200],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Estamos fechados hoje.',style: homeMessage,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
