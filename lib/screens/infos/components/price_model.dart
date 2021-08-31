import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabanas_barbershop/helpers/style.dart';


class PriceBottomModel extends StatefulWidget {

  final String description;
  final String price;

  const PriceBottomModel({Key key, this.description, this.price}) : super(key: key);
  @override
  _PriceBottomModelState createState() => _PriceBottomModelState();
}

class _PriceBottomModelState extends State<PriceBottomModel> {

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        duration: const Duration(milliseconds: 1000),
        position: 1,
        child: SlideAnimation(
          verticalOffset: 150,
          child: FadeInAnimation(
            child: Text('${widget.description} - R\$ ${widget.price}', style: subtitleMonthPageStyle,),
          ),
        )
    );
  }
}
