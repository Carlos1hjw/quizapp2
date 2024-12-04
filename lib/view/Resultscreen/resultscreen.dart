import 'package:apptest/view/CatagoryScreen/catagoryscreen.dart';
import 'package:apptest/view/Quizscreen/quizscreen.dart';
import 'package:apptest/dummydb.dart';
import 'package:apptest/view/openscreen/openscreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  const ResultScreen({super.key, required this.score});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final List<String> categories = quizCategories
        .map((category) => category['CategoryName'] as String)
        .toList();
  final List<String> txt = ["Retry", "Share"];
  final List<IconData> ics = [Icons.restart_alt, Icons.share_outlined];

  int starcount = 0;

  @override
  void initState() {
    super.initState();
    calculateper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CatagoryScreen()),
                );
              },
              child: const Text(
                "Catagories",
                style: TextStyle(color: Colors.white),
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Openscreen()),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: index == 1 ? 30 : 0,
                        ),
                        child: Icon(
                          Icons.star,
                          color: starcount > index
                              ? Colors.yellowAccent
                              : Colors.grey,
                          size: index == 1 ? 70 : 40,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    starcount >= 2 ? "Congratulations" : "Try Again",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Score",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.score} / 13",
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Quizscreen(
                                    category: quizCategories[index]
                                        ['Questions'],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(ics[index]),
                                const SizedBox(width: 5),
                                Text(
                                  txt[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (starcount >= 2)
                Positioned(
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/Animation - 1731924816439.json',
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }

  void calculateper() {
    num percentage = (widget.score / Dummydb().numbers.length) * 100;
    if (percentage >= 90) {
      starcount = 3;
    } else if (percentage >= 50) {
      starcount = 2;
    } else if (percentage >= 30) {
      starcount = 1;
    }
  }
}
