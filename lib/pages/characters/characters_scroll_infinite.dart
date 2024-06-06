import 'package:flutter/material.dart';
import 'package:secondapp/models/characters_model.dart';
import 'package:secondapp/repositories/marvel/marvel_repository.dart';
import 'package:secondapp/shared/Custom_buttom.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class CharacterSrollInfinitePage extends StatefulWidget {
  const CharacterSrollInfinitePage({super.key});

  @override
  State<CharacterSrollInfinitePage> createState() =>
      _CharacterSrollInfinitePageState();
}

class _CharacterSrollInfinitePageState
    extends State<CharacterSrollInfinitePage> {
  late MarvelRepository characterRepository;
  ScrollController scroolController = ScrollController();
  CharactersModel charactersModel = CharactersModel();
  bool load = false;
  bool loadinicial = false;
  int offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    characterRepository = MarvelRepository();
    scroolController.addListener(() {
      var posicaoParaPaginar = scroolController.position.maxScrollExtent * 0.7;
      if (scroolController.position.pixels > posicaoParaPaginar) {
        getData();
      }
    });
    getData();

    super.initState();
  }

  getData() async {
    if (load) return;
    if (charactersModel.data == null) {
      loadinicial = true;
      setState(() {});
      charactersModel = await characterRepository.getCharacters(offset);
      loadinicial = false;
    } else {
      load = true;
      setState(() {});
      offset = offset + charactersModel.data!.count!;
      var result = await characterRepository.getCharacters(offset);
      charactersModel.data!.results!.addAll(result.data!.results!);
      load = false;
    }
    setState(() {});
  }

  int getQuantAtual() {
    try {
      return offset + charactersModel.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: CustomTitle.buildMainTitle(
                context, "Marvel  ${getQuantAtual()} heroes"),
          ),
          drawer: const DrawerComponent(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Expanded(
                  child: loadinicial
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          controller: scroolController,
                          itemCount: (charactersModel.data == null)
                              ? 0
                              : charactersModel.data!.results!.length,
                          itemBuilder: (context, index) {
                            var hero = charactersModel.data!.results![index];
                            return Container(
                              height: 600,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Image.network(
                                          "${hero.thumbnail!.path!}.${hero.thumbnail!.extension!}",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomTitle.buildTitle(
                                          context, hero.name.toString()),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: CustomTitle.buildSubTitle(
                                            context,
                                            hero.description.toString()),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          )),
    );
  }
}
