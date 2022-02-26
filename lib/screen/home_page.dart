import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worddle/notifier/worddle_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WorddleNotifier notifier;

  addToList(String text) {
    HapticFeedback.lightImpact();
    if (text == "<=") {
      notifier.remove();
    } else {
      notifier.add(text);
    }
  }

  Widget customButton(String text) {
    return GestureDetector(
      onTap: () {
        addToList(text);
        if (notifier.wordList.join("") == notifier.word) {
          notifier.generateRandomWord();
          notifier.clearList();
          notifier.changeHint(false);
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          )),
    );
  }

  List<String> firstRow = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
  List<String> secondRow = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
  List<String> thirdRow = ['Z', 'X', 'C', 'V', 'B', 'N', 'M', '<='];
  @override
  void initState() {
    super.initState();
    notifier = Provider.of<WorddleNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, title: const Text("WORDDLE"), centerTitle: true),
      body: Consumer<WorddleNotifier>(
        builder: (context, notifier, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 16,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, int index) {
                      return Card(
                        color: notifier.list[index] == " "
                            ? Colors.teal[100]
                            : Colors.teal[200],
                        elevation: 8,
                        child: Center(
                          child: Text(
                            notifier.list[index],
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              ///hint widget
              Center(
                child: Visibility(
                  visible: notifier.hint,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(notifier.word,
                        style: const TextStyle(fontSize: 24)),
                  ),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: notifier.word.length,
                      itemBuilder: (context, int index) {
                        return Container(
                            height: 35,
                            width: 40,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal)),
                            child: const Text(""));
                      },
                    ),
                  ),

                  ///upper widget
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: notifier.wordList.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          height: 30,
                          width: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                          ),
                          child: Text(notifier.wordList[index] ?? "",
                              style: const TextStyle(fontSize: 26)),
                        );
                      },
                    ),
                  ),
                ],
              ),

              /// keyboard
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// first row of keyboard
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // scrollDirection: Axis.horizontal,
                        //  shrinkWrap: true,
                        children: firstRow.map((e) => customButton(e)).toList(),
                      ),
                    ),
                    /*   SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: firstRow.map((e) => customButton(e)).toList(),
                      ),
                    ),*/

                    /// second row of keyboard
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // scrollDirection: Axis.horizontal,
                        //  shrinkWrap: true,
                        children:
                            secondRow.map((e) => customButton(e)).toList(),
                      ),
                      /* ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children:
                            secondRow.map((e) => customButton(e)).toList(),
                      ),*/
                    ),

                    /// third row of keyboard
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // scrollDirection: Axis.horizontal,
                        //  shrinkWrap: true,
                        children: thirdRow.map((e) => customButton(e)).toList(),
                      ),
                    ),
                    /* SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: thirdRow.map((e) => customButton(e)).toList(),
                      ),
                    ),*/
                  ],
                ),
              ),

              /// shuffle , hint , skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                      style: const ButtonStyle(),
                      onPressed: notifier.listShuffle,
                      icon: const Icon(Icons.shuffle),
                      label: const Text("SHUFFLE")),
                  OutlinedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        notifier.changeHint(notifier.hint ? false : true);
                      },
                      icon: const Icon(Icons.lightbulb),
                      label: const Text("HINT")),
                  OutlinedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        notifier.generateRandomWord();
                        notifier.wordList.clear();
                        notifier.hint = false;
                      },
                      icon: const Icon(Icons.skip_next),
                      label: const Text("SKIP")),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
