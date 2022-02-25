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
        title: "Worddle",
        home: const HomePage(),
      ),
    );
  }
}
/*

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal,
        child: Center(
            child: Text(
          "W",
          style: GoogleFonts.dancingScript(
             // fontStyle: FontStyle.normal,
              color: Colors.white,
              fontSize: 200,
              fontWeight: FontWeight.w900,),
        )),
      ),
    );
  }
}
*/
