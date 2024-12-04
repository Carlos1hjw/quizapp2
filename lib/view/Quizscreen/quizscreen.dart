import 'package:apptest/view/CatagoryScreen/catagoryscreen.dart';
import 'package:apptest/view/Resultscreen/resultscreen.dart';
import 'package:apptest/dummydb.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class Quizscreen extends StatefulWidget {
  dynamic category;
  Quizscreen({super.key, this.category});

  @override
  State<Quizscreen> createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  late Timer _timer;
  int _timeLeft = 10;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _goToNextQuestion();
        }
      });
    });
  }

  void _goToNextQuestion() {
    _timer.cancel();
    if (currentQuestionIndex < widget.category.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        _startTimer();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _timeLeft / 10;
    double questionProgress =
        (currentQuestionIndex + 1) / Dummydb().numbers.length;
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatagoryScreen(),
                  ));
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            )),
        title: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResultScreen(
                            score: 0,
                          )));
            },
            child: const Text(
              "Skip All",
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "${Dummydb().numbers[currentQuestionIndex]}/ 13",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            LinearPercentIndicator(
              lineHeight: 14.0,
              percent: questionProgress,
              backgroundColor: Colors.grey,
              progressColor: Colors.green,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          right: 0,
                          child: CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 10.0,
                            percent: progress,
                            center: Text(
                              '$_timeLeft s',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.center,
                            ),
                            progressColor: Colors.red,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.category[currentQuestionIndex]["Question"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (selectedAnswerIndex ==
                            widget.category[currentQuestionIndex]
                                ["Answerindex"])
                          Center(
                            child: Lottie.asset(
                                'assets/animations/Animation - 1731927291467.json'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      if (selectedAnswerIndex == null) {
                        selectedAnswerIndex = index;
                        if (selectedAnswerIndex ==
                            widget.category[currentQuestionIndex]
                                ["Answerindex"]) {
                          score++;
                        }
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: getcolor(index), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.category[currentQuestionIndex]["Options"]
                                  [index],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.circle_outlined,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (selectedAnswerIndex != null)
              InkWell(
                onTap: _goToNextQuestion,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    currentQuestionIndex == 12 ? "Get Score" : "Next",
                    style: const TextStyle(color: Colors.white),
                  )),
                ),
              )
          ],
        ),
      ),
    );
  }

  Color getcolor(int clickindex) {
    if (selectedAnswerIndex != null) {
      if (widget.category[currentQuestionIndex]["Answerindex"] == clickindex) {
        return Colors.green;
      }
    }
    if (selectedAnswerIndex == clickindex) {
      if (selectedAnswerIndex ==
          widget.category[currentQuestionIndex]["Answerindex"]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}
