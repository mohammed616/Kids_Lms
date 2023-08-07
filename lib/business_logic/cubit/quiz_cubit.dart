import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/data/models/quiz_model.dart';
import 'package:kids_lms_project/data/repository/quiz_repository.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:kids_lms_project/presentation/screen/quiz_answers.dart';
class QuizCubit extends Cubit<List<Test>> {
  final String url;
  List<Question> correctlyAnsweredQuestions = [];
  QuizCubit(this.url) : super([]);

  Future<void> loadQuestions() async {
    final response = await http.get(Uri.parse(url));
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final tests = jsonList.map((testData) => Test.fromJson(testData)).toList();
    emit(tests);
  }

  Future<void> sendPointsToBackend(int points) async {
    final url = 'http://example.com/api/points';
    final response = await http.post(
      Uri.parse(url),
      body: {'points': points.toString()},
    );

    if (response.statusCode == 200) {
      print('Points sent to the backend.');
    } else {
      print('Failed to send points to the backend.');
    }
  }


  void moveToNextQuestion(BuildContext context, bool isAnswerCorrect) {
    Timer(Duration(milliseconds: 500), () {
      final currentTest = state[0];
      final questions = currentTest.questions;
      final currentQuestion = questions[currentTest.currentQuestionIndex];


      if (currentQuestion.points == 0 && isAnswerCorrect) {
        context.read<QuizCubit>().correctlyAnsweredQuestions.add(currentQuestion);
        currentQuestion.points = 1;
      }

      currentTest.currentQuestionIndex++;

      if (currentTest.currentQuestionIndex >= questions.length) {
        showResult(context);
        return;
      }

      emit(List.from(state));
    });
  }

  void showResult(BuildContext context) {
    final correctlyAnsweredQuestions = context.read<QuizCubit>().correctlyAnsweredQuestions;
    final totalQuestions = state[0].questions.length;
    final correctAnswers = correctlyAnsweredQuestions.length;
    final incorrectAnswers = totalQuestions - correctAnswers;

    final totalPoints = correctlyAnsweredQuestions.fold<int>(
      0,
          (sum, question) => sum + question.points,
    );
    sendPointsToBackend(totalPoints);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //backgroundColor: MyAppColors.darkGreen,
          title: Center(child: Text('Quiz Result',style: GoogleFonts.quicksand(),)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Text('Correct Answers: $correctAnswers'),
              Text('Result: $totalPoints / $totalQuestions ',style: GoogleFonts.quicksand(),),
              SizedBox(height: 10,),
              //Text('Incorrect Answers: $incorrectAnswers'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(MyAppColors.purple),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false,
                      );
                    },
                    child: Text('Exit',style: GoogleFonts.quicksand(),),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(MyAppColors.purple),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => QuizAnswers()),
                            (route) => false,
                      );
                    },
                    child: Text('the solution',style: GoogleFonts.quicksand(),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}