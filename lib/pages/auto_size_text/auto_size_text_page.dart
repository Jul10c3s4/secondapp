import 'package:flutter/material.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AutoSizeTextPage extends StatefulWidget {
  const AutoSizeTextPage({super.key});

  @override
  State<AutoSizeTextPage> createState() => _AutoSizeTextPageState();
}

class _AutoSizeTextPageState extends State<AutoSizeTextPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CustomTitle.buildMainTitle(context, "AutoSizeTextPage"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: const AutoSizeText(
                    " No entanto, não podemos esquecer que a execução dos pontos do programa acarreta um processo de reformulação e modernização dos modos de operação convencionais. Por outro lado, o fenômeno da Internet prepara-nos para enfrentar situações atípicas decorrentes das condições financeiras e administrativas exigidas. Todas estas questões, devidamente ponderadas, levantam dúvidas sobre se a competitividade nas transações comerciais faz parte de um processo de gerenciamento do levantamento das variáveis envolvidas. O que temos que ter sempre em mente é que a revolução dos costumes é uma das consequências das posturas dos órgãos dirigentes com relação às suas atribuições",
                    maxLines: 15,
                    minFontSize: 12,
                  ),
                ),
              ),
            ),
            CustomTitle.buildTitle(context, "")
          ],
        ),
      ),
    );
  }
}
