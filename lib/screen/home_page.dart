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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(elevation: 0, title: const Text("WORDDLE"), centerTitle: true),
      body: Consumer<WorddleNotifier>(
        builder: (context, notifier, child) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      itemCount: 16,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (context, int index) {
                        log("grid view-------");
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            if (notifier.wordList.length <
                                notifier.word.length) {
                              if (notifier.list[index] != " ") {
                                notifier.add(notifier.list[index]);
                                if (notifier.wordList.join("") ==
                                    notifier.word) {
                                  notifier.generateRandomWord();
                                  notifier.clearList();
                                  notifier.changeHint(false);
                                }
                              }
                            }
                          },
                          child: Card(
                            color: notifier.list[index] == " "
                                ? Colors.teal[100]
                                : Colors.teal[200],
                            elevation: 10,
                            child: Center(
                              child: Text(
                                notifier.list[index],
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: notifier.word.length,
                        itemBuilder: (context, int index) {
                          print("this is a list of word");
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
                      height: 70,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Visibility(
                      visible: notifier.hint,
                      child: Text(notifier.word,
                          style: const TextStyle(fontSize: 28)),
                    ),
                    Visibility(
                      visible: notifier.wordList.isEmpty ? false : true,
                      child: TextButton(
                          onPressed: () {
                            notifier.remove();
                          },
                          child: const Icon(Icons.delete)),
                    )
                  ],
                ),
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
            ),
          );
        },
      ),
    );
  }
}
