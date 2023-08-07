import 'package:kids_lms_project/data/models/quiz_model.dart';

class Test {
  final int quiz_id;
  final List<Question> questions;
  int currentQuestionIndex;

  Test({required this.quiz_id, required this.questions, this.currentQuestionIndex = 0});

  factory Test.fromJson(Map<String, dynamic> json) {
    final questionsData = json['0'] as List<dynamic>;
    final questions = questionsData.map((questionData) => Question.fromJson(questionData)).toList();

    return Test(quiz_id: json['quiz_id'], questions: questions);
  }
}