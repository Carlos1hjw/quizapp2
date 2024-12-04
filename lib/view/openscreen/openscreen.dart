import 'package:apptest/view/CatagoryScreen/catagoryscreen.dart';
import 'package:flutter/material.dart';

class Openscreen extends StatefulWidget {
  const Openscreen({super.key});

  @override
  State<Openscreen> createState() => _OpenscreenState();
}

class _OpenscreenState extends State<Openscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            height: 1024,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/qapp234.webp"),
              fit: BoxFit.cover,
            )),
            child: Stack(children: [
              Positioned(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "WELCOME",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const Text(
                        "TO",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const Text(
                        "QUIZ APP",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CatagoryScreen(),
                              ));
                        },
                        child: Container(
                          color: Colors.blue.shade800,
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Questions",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
