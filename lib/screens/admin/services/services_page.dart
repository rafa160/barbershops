import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/bloc/price_bloc.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/components/custom_form_alert_dialog.dart';
import 'package:kabanas_barbershop/components/custom_info_price_description_card.dart';
import 'package:kabanas_barbershop/helpers/style.dart';
import 'package:kabanas_barbershop/models/price_model.dart';
import 'package:kabanas_barbershop/screens/admin/services/services_module.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  var priceBloc = ServicesModule.to.getBloc<PriceBloc>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    priceBloc.getListOfPrices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: CustomAppBar(
        title: 'Área de Serviços',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            children: [
              StreamBuilder(
               stream: priceBloc.priceModelStream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomColorCircularProgressIndicator(),
                      );
                    default:
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length + 1,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 8,
                      childAspectRatio: 6 / 1.3,
                    ),
                    itemBuilder: (_, index) {
                      if(index < snapshot.data.length) {
                        PriceModel price = snapshot.data[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1050),
                          child: SlideAnimation(
                            verticalOffset: 120,
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: CustomPriceDescriptionCard(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomFormAlertDialog(
                                          price: price,
                                          number: 1,
                                          text: 'Editar ${price.description}',
                                        );
                                      }
                                  );
                                },
                                onLongPress: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomFormAlertDialog(
                                          price: price,
                                          text: 'Deletar ${price.description}',
                                          number: 2,
                                        );
                                      }
                                  );
                                },
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.cut,
                                      size: 15,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('${price.description} - ${price.price}', style: buttonColorBlack,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1050),
                          child: SlideAnimation(
                            verticalOffset: 120,
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: CustomPriceDescriptionCard(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomFormAlertDialog(
                                          price: null,
                                          text: 'Adicionar ',
                                          widget: CustomButton(
                                            widget: Text('adicionar', style: buttonColors,),
                                            onPressed: () async {
                                              FocusScope.of(context).requestFocus(new FocusNode());
                                              if (_formKey.currentState.validate()) {
                                                _formKey.currentState.save();
                                                // await userBloc.signIn(
                                                //     _formKey.currentState.value['email'],
                                                //     _formKey.currentState.value['password'],
                                                //     context);
                                              }
                                            },
                                          ),
                                        );
                                      }
                                  );
                                },
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.plus,
                                      size: 15,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('adicionar', style: buttonColorBlack,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
