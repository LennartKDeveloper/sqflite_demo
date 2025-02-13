import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sqflite_demo/data/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper helper = DatabaseHelper();

  String answer = "";

  Future<void> _getInvoiceDescription(String goae) async {
    var table = await helper.getAllFromGoae(goae);
    print(table["description"]);
    setState(() {
      answer = table["description"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    final List<BoxShadow> myBoxShadow = [
      BoxShadow(
        spreadRadius: -10,
        blurRadius: 5,
        offset: const Offset(-2, -2),
        color: Colors.black.withOpacity(0.5),
      ),
      BoxShadow(
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(2, 2),
        color: Colors.black.withOpacity(0.5),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const Gap(16),
            const Icon(
              Icons.search_rounded,
              color: Colors.deepPurple,
            )
          ],
        )),
      ),
      body: ListView(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 50, right: 50, top: 100, bottom: 100),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade300,
                boxShadow: myBoxShadow,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (answer.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              answer,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      const Gap(32),
                      const Text(
                        "Enter a number and i´ll check the invoice desciption: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller: nameController,
                      ),
                      const Gap(32),
                      GestureDetector(
                        onTap: () =>
                            _getInvoiceDescription(nameController.text.trim()),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              boxShadow: myBoxShadow,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                                child: Text(
                              "Generate",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 2),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
