import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabanas_barbershop/app_module.dart';
import 'package:kabanas_barbershop/bloc/date_bloc.dart';
import 'package:kabanas_barbershop/components/custom_appbar.dart';
import 'package:kabanas_barbershop/components/custom_color_circular_indicator.dart';
import 'package:kabanas_barbershop/models/user_model.dart';

class CalendarEmployeePage extends StatefulWidget {
  final String month;
  final UserModel employee;

  const CalendarEmployeePage({Key key, this.month, this.employee})
      : super(key: key);

  @override
  _CalendarEmployeePageState createState() => _CalendarEmployeePageState();
}

class _CalendarEmployeePageState extends State<CalendarEmployeePage> with TickerProviderStateMixin {

  var dateBloc = AppModule.to.getBloc<DateBloc>();
  TabController _nestedTabController;

  @override
  void initState() {
    dateBloc.getMessageForEachDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _nestedTabController = new TabController(length: dateBloc.num.length, vsync: this);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Agenda do ${widget.employee.name}',
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: dateBloc.getWeekDay(),
                builder: (context, snapshot){
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CustomColorCircularProgressIndicator(),
                      );
                    default:
                  }
                  return TabBar(
                      controller: _nestedTabController,
                      indicatorColor: Colors.blue,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black54,
                      isScrollable: true,
                      tabs: dateBloc.tabs
                  );
                },
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                      controller: _nestedTabController,
                      // physics: NeverScrollableScrollPhysics(),
                      children: dateBloc.widget
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
