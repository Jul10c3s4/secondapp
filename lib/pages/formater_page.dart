import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class FormaterPage extends StatefulWidget {
  const FormaterPage({super.key});

  @override
  State<FormaterPage> createState() => _FormaterPageState();
}

class _FormaterPageState extends State<FormaterPage> {
  var numberUS = NumberFormat('###.0#', 'en_US');
  var numberBR = NumberFormat('###.0#', 'pt_BR');

  /*var data = DateTime(2023, 05, 09);
  var dataUS = DateFormat('EEEEE', 'en_US');
  var dataBR = DateFormat('EEEEE', 'pt_BR');*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Intl.defaultLocale = 'pt_BR';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "FormaterPage"),
        ),
        drawer: const DrawerComponent(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTitle.buildTitle(context, "Formatos de números: "),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CustomTitle.buildTitle(context, "estadunidense: "),
                  CustomTitle.buildSubTitle(context, numberUS.format(12.421))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomTitle.buildTitle(context, "brasileiro: "),
                  CustomTitle.buildSubTitle(context, numberBR.format(12.421))
                ],
              ),
              /*CustomTitle.buildTitle(context, "Formatos de datas: "),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CustomTitle.buildTitle(context, "estadunidense: "),
                  CustomTitle.buildSubTitle(context, dataUS.format(data))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomTitle.buildTitle(context, "brasileiro: "),
                  CustomTitle.buildSubTitle(context, dataBR.format(data))
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
