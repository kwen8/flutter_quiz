import 'package:flutter/material.dart';

import '../utils/quiz.dart';
import '../utils/question.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("陈科文帅不帅?", true),
    new Question("你是陈科文老婆吗", true),
    new Question("你最爱的是陈科文吗", true)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(children: <Widget>[
          new AnswerButton(true, () => handleAnswer(true)),
          new QuestionText(questionText, questionNumber),
          new AnswerButton(false, () => handleAnswer(false))
        ]),
        overlayShouldBeVisible
            ? new CorrectWrongOverlay(isCorrect, () {
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  if (currentQuestion != null) {
                    questionText = currentQuestion.question;
                  }
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container()
      ],
    );
  }
}
