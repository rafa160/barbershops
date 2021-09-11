import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/bloc/version_bloc.dart';
import 'package:kabanas_barbershop/components/colored_custom_container.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_form_field.dart';
import 'package:kabanas_barbershop/components/custom_modal_bottom_sheet.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/screens/admin/admin_module.dart';
import 'package:kabanas_barbershop/screens/login/login_module.dart';
import 'package:kabanas_barbershop/screens/profile/employee_profile/employee_profile_module.dart';
import 'package:kabanas_barbershop/screens/profile/profile_module.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userBloc = AppModule.to.getBloc<UserBloc>();
  var versionBloc = ProfileModule.to.getBloc<VersionBloc>();
  var dateBloc = AppModule.to.getBloc<DateBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 1,
                widget: ColoredCustomContainer(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FaIcon(
                        FontAwesomeIcons.userCircle,
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
                              Text('Perfil', style: appBarTitle,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomAnimatedContainer(
                  verticalOffset: 800,
                  milliseconds: 1500,
                  position: 2,
                  widget:  CustomFormField(
                    initialValue: userBloc.user.name,
                    enabled: false,
                    obscureText: false,
                  ),
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 3,
                widget: CustomFormField(
                  initialValue: userBloc.user.email,
                  enabled: false,
                  obscureText: false,
                ),
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 4,
                widget: CustomFormField(
                  initialValue: userBloc.user.whatsApp,
                  enabled: false,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 5,
                widget: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: CustomButton(
                    widget: Text(
                      'sair',
                      style: buttonColors,
                    ),
                    onPressed: () async {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        context: context,
                        builder: (builder) {
                          return CustomModalBottomSheet(
                            title: 'Deseja deslogar?',
                            actionButtonTitle: 'deslogar',
                            onPressed: () async {
                              await userBloc.signOut();
                              await Get.offAll(() => LoginModule());
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 6,
                widget: userBloc.user.admin == true ? Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: CustomButton(
                    widget: Text(
                      'área do administrador',
                      style: buttonColors,
                    ),
                    onPressed: () async {
                      Get.to(() => AdminModule());
                    },
                  ),
                ) : Container(),
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 7,
                widget: userBloc.user.status.index == 1 ? Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: CustomButton(
                    widget: Text(
                      'área do funcionário',
                      style: buttonColors,
                    ),
                    onPressed: () async {
                      int weekDay = await dateBloc.getWeekDay();
                      Get.to(() => EmployeeProfileModule(userBloc.user, weekDay));
                    },
                  ),
                ) : Container(),
              ),
              CustomAnimatedContainer(
                verticalOffset: 800,
                milliseconds: 1500,
                position: 7,
                widget: userBloc.user.status.index == 2 ? Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: CustomButton(
                    widget: Text(
                      'minhas reservas',
                      style: buttonColors,
                    ),
                    onPressed: () async {
                      // Get.to(() => EmployeeProfileModule(userBloc.user));
                    },
                  ),
                ) : Container(),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: versionBloc.streamVersion$,
                  builder: (context, snapshot) {
                    return CustomAnimatedContainer(
                      milliseconds: 1500,
                      position: 8,
                      verticalOffset: 800,
                      widget: Center(
                        child: Text(
                          "versão ${snapshot.data}", style: titleColoredForms,
                        ),
                      ),
                    );
                  }
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
    );
  }
}
