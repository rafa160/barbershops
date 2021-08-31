import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/colored_custom_container.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/user_model.dart';
import 'package:kabanas_barbershop/screens/login/login_module.dart';
import 'package:kabanas_barbershop/screens/main/main_module.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  var userBloc = AppModule.to.getBloc<UserBloc>();

  @override
  void initState() {
    _redirectToHome();
    super.initState();
  }

  Future _redirectToHome() async {
    UserModel userModel = await userBloc.loggedUserAsync();
    if(userModel != null) {
      UserModel tourUser = await userBloc.getUserModel(id: userModel.id);
      if(await userBloc.isLogged() && tourUser.available == true) {
        await Get.offAll(() => MainModule());
      }
      else if (await userBloc.isLogged() && tourUser.available == false) {
        await Get.offAll(() => LoginModule());
      }
    } else {
      await Get.offAll(() => LoginModule());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'logo',
        child: ColoredCustomContainer(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              Center(
                child: FaIcon(
                  FontAwesomeIcons.meteor,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('sponsored by Anduril Software', style: typeText,),),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
