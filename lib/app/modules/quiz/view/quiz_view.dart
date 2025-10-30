import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/quiz/controller/quiz_controller.dart';
import 'package:flutter_application_1/app/modules/result_page/views/result_view.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QuizView extends GetView<QuizController> {
  final String categoryName;
  const QuizView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Memanggil data quiz
    controller.fetchQuizzes(categoryName);

    return Scaffold(
      body: Obx(() {
        if (controller.quizzes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.quizzes[0]['questions'] == null ||
            controller.quizzes[0]['questions'].isEmpty) {
          return Scaffold(
            body: Center(
              child: Text(
                'Tidak ada pertanyaan di kategori $categoryName',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            backgroundColor: Colors.deepPurple,
          );
        }

        final currentQuestion = controller
            .quizzes[0]['questions'][controller.currentQuestionIndex.value];
        final answers = currentQuestion['answers'] as List;

        return Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                radialGradient,
                radialGradient2,
                radialGradient3,
                radialGradient4,
              ],
              center: Alignment.center,
              radius: 1.7,
              focal: Alignment.center,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      'Question ${controller.currentQuestionIndex.value + 1} of ${controller.quizzes[0]['questions'].length}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: 850,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 300,
                                child: Text(
                                  currentQuestion['question_text'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...answers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final answer = entry.value;
                        final optionLetter = String.fromCharCode(65 + index);
                        final bool isSelected =
                            controller.selectedAnswerIndex.value == index;

                        return GestureDetector(
                          onTap: () {
                            controller.selectedAnswerIndex.value = index;
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFC8FCEA)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    optionLetter,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    answer['answer_text'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ElevatedButton(
                          onPressed:
                              controller.selectedAnswerIndex.value == null
                              ? null
                              : controller.nextQuestion,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 60),
                            backgroundColor: btnquiz,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.currentQuestionIndex.value ==
                                  controller.quizzes[0]['questions'].length -
                                      1) {
                                Get.to(ResultPage());
                              } else {
                                controller.currentQuestionIndex.value++;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.currentQuestionIndex.value ==
                                            controller
                                                    .quizzes[0]['questions']
                                                    .length -
                                                1
                                        ? 'Finish'
                                        : 'Next',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Icon(
                                  MdiIcons.chevronDoubleRight,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
