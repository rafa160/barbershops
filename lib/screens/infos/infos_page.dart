import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabanas_barbershop/bloc/price_bloc.dart';
import 'package:kabanas_barbershop/components/colored_custom_container.dart';
import 'package:kabanas_barbershop/components/container_placeholder.dart';
import 'package:kabanas_barbershop/components/custom_animated_container.dart';
import 'package:kabanas_barbershop/components/custom_infos_page_card.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/helpers/utils.dart';
import 'package:kabanas_barbershop/models/price_model.dart';
import 'package:kabanas_barbershop/screens/infos/components/price_model.dart';
import 'package:kabanas_barbershop/screens/infos/infos_module.dart';
import 'package:url_launcher/url_launcher.dart';

class InfosPage extends StatefulWidget {
  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  var priceBloc = InfosModule.to.getBloc<PriceBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAnimatedContainer(
              milliseconds: 1550,
              horizontalOffset: 150,
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
                      FontAwesomeIcons.info,
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
                              'Informações',
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
              height: 10,
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: AnimationLimiter(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 1550),
                          position: 1,
                          child: SlideAnimation(
                            horizontalOffset: 150,
                            child: FadeInAnimation(
                                child: CustomInfoPageCard(
                                width: MediaQuery.of(context).size.width * 0.3,
                                onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (builder) {
                                    return FutureBuilder(
                                      future: priceBloc.getPriceList(),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                          case ConnectionState.waiting:
                                            return Container();
                                          default:
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,

                                          itemCount: priceBloc.priceList.length,
                                          itemBuilder: (context, index) {
                                            PriceModel model =
                                                snapshot.data[index];
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)),
                                              title:CustomAnimatedContainer(
                                                  verticalOffset: 200,
                                                  position: 2,
                                                  milliseconds: 800,
                                                  widget: Text('${model.description}  R\$${model.price}',style: subtitleMonthPageStyle,)),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                                text: 'Valores',
                                icon: FaIcon(
                                FontAwesomeIcons.moneyBillAlt,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                          )),
                    ),
                    Flexible(
                      child: AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 1550),
                          position: 2,
                          child: SlideAnimation(
                            horizontalOffset: 150,
                            child: FadeInAnimation(
                                child: CustomInfoPageCard(
                              width: MediaQuery.of(context).size.width * 0.3,
                              onTap: () {
                                String url = getPhoneLaunch();
                                launch(url);
                              },
                              text: 'Contato',
                              icon: FaIcon(
                                FontAwesomeIcons.phone,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                          )),
                    ),
                    Flexible(
                      child: AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 1550),
                          position: 3,
                          child: SlideAnimation(
                            horizontalOffset: 150,
                            child: FadeInAnimation(
                                child: CustomInfoPageCard(
                              width: MediaQuery.of(context).size.width * 0.3,
                              onTap: () async {
                                String url = ownerWhatsAppUrl();
                                await launch(url);
                              },
                              text: 'WhatsApp',
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 1550),
                    position: 3,
                    child: SlideAnimation(
                      horizontalOffset: 150,
                      child: FadeInAnimation(
                        child: CustomInfoPageCard(
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            String url = locationUrl();
                            await launch(url);
                          },
                          text: 'Localização',
                          icon: FaIcon(
                            FontAwesomeIcons.globeAmericas,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
