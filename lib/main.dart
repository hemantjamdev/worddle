import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worddle/notifier/theme_notifier.dart';
import 'package:worddle/notifier/worddle_notifier.dart';
import 'screen/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const WorddleApp()));
}

class WorddleApp extends StatelessWidget {
  const WorddleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorddleNotifier()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData(primaryColor: Colors.teal, primarySwatch: Colors.teal),
        debugShowCheckedModeBanner: false,
        title: "Worddle App",
        home: const HomePage(),
      ),
    );
  }
}
