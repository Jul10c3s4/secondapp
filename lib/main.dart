import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:secondapp/models/dados_cadastrais_model.dart';
import 'package:secondapp/models/task_hive_model.dart';
import 'package:secondapp/pages/splash_screen/spalsh_screen_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:easy_localization/easy_localization.dart';
import 'package:secondapp/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TaskHiveModelAdapter());
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
          Locale('fr', 'CH')
        ],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('pt', 'BR'),
        child: const MyApp()),
  );
}
