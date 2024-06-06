import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:secondapp/pages/auto_size_text/auto_size_text_page.dart';
import 'package:secondapp/pages/battery/battery_page.dart';
import 'package:secondapp/pages/camera/camera_page.dart';
import 'package:secondapp/pages/configuracoes-page.dart';
import 'package:secondapp/pages/connectivity_plus/connectivity_plus_page.dart';
import 'package:secondapp/pages/dados_cadastrais/cadastro_page_shared_preferences.dart';
import 'package:secondapp/pages/contact-page.dart';
import 'package:secondapp/pages/formater_page.dart';
import 'package:secondapp/pages/geolocator/geolocator_page.dart';
import 'package:secondapp/pages/login_page.dart';
import 'package:secondapp/pages/page-view.dart';
import 'package:secondapp/pages/profile.dart';
import 'package:secondapp/pages/qr_code/qr_code_page.dart';
import 'package:secondapp/pages/tab_bar_view.dart';
import 'package:secondapp/pages/task-page.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/show-dialog.dart';
import 'package:secondapp/shared/textComponent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.rectangle),
                currentAccountPicture: SizedBox(
                  width: double.infinity,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.network(
                        "https://certone.com.br/wp-content/uploads/2020/01/pessoa-apontando-png-5.png"),
                  ),
                ),
                accountName: CustomTitle.buildTitle(context, "Julio Cesar"),
                accountEmail:
                    CustomTitle.buildSubTitle(context, 'juliocesar@gmail.com')),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.userPen),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        },
                        child: CustomTitle.buildSubTitle(
                            context, "cadastrar dev")),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.pagelines),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PageViewPage()));
                      },
                      child: CustomTitle.buildSubTitle(context, "PageView"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TabBarViewPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "TabView"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.list),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TaksPage()));
                      },
                      child: CustomTitle.buildSubTitle(context, "Tarefas"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              title: const Text(
                                "Confirmação de proxima tela",
                              ),
                              content: const Text(
                                  "Tem certeze que deseja ver os contatos ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomTitle.buildCancelTitle(
                                        context, "Cancelar")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ContactPage()));
                                    },
                                    child:
                                        CustomTitle.buildOkTitle(context, "OK"))
                              ],
                            );
                          });
                    },
                    child: CustomTitle.buildSubTitle(context, "contatos")),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              child: Column(children: [
                                CustomTitle.buildTitle(
                                    context, "Termos de uso"),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTitle.buildSubTitle(context,
                                    "Ainda assim, existem dúvidas a respeito de como o consenso sobre a necessidade de qualificação afeta positivamente a correta previsão dos métodos utilizados na avaliação de resultados.")
                              ]),
                            );
                          });
                    },
                    child: CustomTitle.buildSubTitle(context, "Termos de uso")),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              title: const Text(
                                "Confirmação de saida",
                              ),
                              content:
                                  const Text("Tem certeze que deseja sair ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomTitle.buildCancelTitle(
                                        context, "Cancelar")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                          (route) => false);
                                    },
                                    child:
                                        CustomTitle.buildOkTitle(context, "OK"))
                              ],
                            );
                          });
                    },
                    child: CustomTitle.buildSubTitle(context, "Sair")),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfiguracoesPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Configurações"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AutoSizeTextPage()));
                  },
                  child:
                      CustomTitle.buildSubTitle(context, "Auto size text Page"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FormaterPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Intl"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BatteryPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Battery page"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse("https://www.dio.me/en"));
                  },
                  child: CustomTitle.buildSubTitle(context, "Ir para a DIO"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await Share.share(
                        'Da uma olhada nesse site incrível: https://www.dio.me/en');
                  },
                  child:
                      CustomTitle.buildSubTitle(context, "Compartilhar texto"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    //é melhor utilizar isso no splash
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();

                    String appName = packageInfo.appName;
                    String packageName = packageInfo.packageName;
                    String version = packageInfo.version;
                    String buildNumber = packageInfo.buildNumber;
                    String platform = Platform.operatingSystem;
                    String hostName = Platform.localHostname;
                    print(appName);
                    print(packageName);
                    print(version);
                    print(buildNumber);
                    print(platform);
                    print(hostName);
                  },
                  child: CustomTitle.buildSubTitle(
                      context, "informações do pacote"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    var directoryTemporary =
                        await path_provider.getTemporaryDirectory();
                    print(directoryTemporary);
                    var suport =
                        await path_provider.getApplicationSupportDirectory();
                    print(suport);
                    var document =
                        await path_provider.getApplicationDocumentsDirectory();
                    print(document);
                  },
                  child: CustomTitle.buildSubTitle(
                      context, "informações de pastas do dispositivo"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                    if (Platform.isAndroid) {
                      AndroidDeviceInfo androidInfo =
                          await deviceInfo.androidInfo;
                      print('Running on ${androidInfo.data}');
                    }
                  },
                  child: CustomTitle.buildSubTitle(
                      context, "informações do dispositivo"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ConnectivityPlusPage()));
                  },
                  child: CustomTitle.buildSubTitle(
                      context, "ConnectivityPlus Page"),
                ),
                InkWell(
                  onTap: () async {
                    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                    if (Platform.isAndroid) {
                      AndroidDeviceInfo androidInfo =
                          await deviceInfo.androidInfo;
                      print('Running on ${androidInfo.data}');
                    }
                  },
                  child: CustomTitle.buildSubTitle(
                      context, "informações do dispositivo"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GeolocatorPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Geolocator Page"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrcodePage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Qrcode Page"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraPage()));
                  },
                  child: CustomTitle.buildSubTitle(context, "Camera Page"),
                ),
              ].reversed.toList(),
            ),
          )
        ],
      ),
    );
  }
}
