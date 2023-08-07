class Question {
  final int id;
  final String questions;
  final List<Answer> answers;
  int correctAnswerIndex;
  int points;

  Question({
    required this.id,
    required this.questions,
    required this.answers,
    required this.correctAnswerIndex,
    this.points = 0,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final answersData = json['answers'] as List<dynamic>;
    final answers = answersData.map((answerData) => Answer.fromJson(answerData)).toList();

    return Question(
      id: json['id'],
      questions: json['questions'],
      answers: answers,
      correctAnswerIndex: int.parse(json['correctAnswerIndex']),
    );
  }
}

class Answer {
  final int id;
  final String option;

  Answer({required this.id, required this.option,});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(id: json['id'], option: json['option']);
  }
}