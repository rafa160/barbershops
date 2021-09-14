import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/bloc/user_bloc.dart';
import 'package:kabanas_barbershop/components/curved_container.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_png_card.dart';
import 'package:kabanas_barbershop/components/month_card.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userBloc = AppModule.to.getBloc<UserBloc>();
  var dateBloc = AppModule.to.getBloc<DateBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.antiAlias,
          fit: StackFit.loose,
          children: [
            CustomAnimatedContainer(
              verticalOffset: -50,
              horizontalOffset: 120,
              milliseconds: 1000,
              position: 1,
              widget: ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*4/7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff40dedf), Color(0xff0fb2ea)],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 1,
                    widget: Text(
                      'Olá ${userBloc.user.name},', style: homeMessage,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomAnimatedContainer(
                    verticalOffset: 10,
                    horizontalOffset: 120,
                    milliseconds: 1200,
                    position: 2,
                    widget: Text(
                      'Agende seu horário com Kabañas BarberShop.', style: enterpriseWhiteText,
                    ),
                  ),
                  FutureBuilder(
                    future: getTheMonths(dateBloc.month),
                    builder: (context, snapshot){
                      return AnimationLimiter(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: monthList.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 3,
                            childAspectRatio: 4 / 3.6,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 1050),
                              child: SlideAnimation(
                                verticalOffset: 120,
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: CustomPngCard(
                                    month: monthList[index],
                                    onTap: () async {
                                      await dateBloc.getCurrentMonth(monthList[index], context);
                                    },
                                  )
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


