import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabanas_barbershop/components/custom_button.dart';
import 'package:kabanas_barbershop/helpers/style.dart';

class CustomModalBottomSheet extends StatelessWidget {

  final VoidCallback onPressed;
  final String title;
  final String actionButtonTitle;

  const CustomModalBottomSheet({Key key, this.onPressed, this.title, this.actionButtonTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      color: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 20.0),
                child: SizedBox(
                  height: 40,
                  child: Text('Olá,',
                      style:titleForms),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 30),
                child: SizedBox(
                  height: 40,
                  child: Text(title,
                      style:
                      titleForms),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: CustomButton(
                  widget: Text('cancelar', style: buttonColors,),
                  onPressed: (){
                    Get.back();
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(actionButtonTitle,
                          style: buttonColorBlack),
                      onPressed: onPressed
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
