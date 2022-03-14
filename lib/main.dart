import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Icon> _scoreKeeper = [];
  final QuizBrain _quizBrain = QuizBrain();

  void _checkAnswer(bool pickedAnswer) {
    setState(() {
      if (_quizBrain.isFinished()) {
        Alert(
          context: context,
          title: "THE END",
          desc: "You have finished the quiz.",
          style: AlertStyle(
            backgroundColor: Colors.grey[900],
            isButtonVisible: false,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
            descStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ).show();
        _quizBrain.reset();
        _scoreKeeper.clear();
      } else if (_quizBrain.getQuestionAnswer() == pickedAnswer) {
        _scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        _scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      _quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                _checkAnswer(false);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          child: Row(
            children: _scoreKeeper,
          ),
        ),
      ],
    );
  }
}
