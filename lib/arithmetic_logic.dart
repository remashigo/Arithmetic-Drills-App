import 'dart:math';

class ArithmeticLogic {
  // Method to generate a random arithmetic problem
  static String generateProblem() {
    // Create a Random object
    Random random = Random();
    // Generate random operands between 1 and 50
    int operand1 = random.nextInt(50) + 1;
    int operand2 = random.nextInt(50) + 1;
    // Choose a random operator from the list ['+', '-', '×', '÷']
    String operator = ['+', '-', '×', '÷'][random.nextInt(4)];

    // Ensuring multiplication operands are less than or equal to 12
    if (operator == '×') {
      operand1 = random.nextInt(13);
      operand2 = random.nextInt(13);
    }

    // Return the generated problem as a string
    return '$operand1 $operator $operand2';
  }

  // Method to check if the user's answer is correct
  static bool checkAnswer(String problem, int userAnswer) {
    // Split the problem string into operands and operator
    List<String> parts = problem.split(' ');
    int operand1 = int.parse(parts[0]);
    int operand2 = int.parse(parts[2]);
    String operator = parts[1];
    int correctAnswer = 0;

    // Calculate the correct answer based on the operator
    switch (operator) {
      case '+':
        correctAnswer = operand1 + operand2;
        break;
      case '-':
        correctAnswer = operand1 - operand2;
        break;
      case '×':
        correctAnswer = operand1 * operand2;
        break;
      case '÷':
        correctAnswer = operand1 ~/ operand2;
        break;
    }

    // Check if the user's answer matches the correct answer
    return userAnswer == correctAnswer;
  }

  // Method to get the correct answer for a given problem
  static int getCorrectAnswer(String problem) {
    // Split the problem string into operands and operator
    List<String> parts = problem.split(' ');
    int operand1 = int.parse(parts[0]);
    int operand2 = int.parse(parts[2]);
    String operator = parts[1];
    int correctAnswer = 0;

    // Calculate the correct answer based on the operator
    switch (operator) {
      case '+':
        correctAnswer = operand1 + operand2;
        break;
      case '-':
        correctAnswer = operand1 - operand2;
        break;
      case '×':
        correctAnswer = operand1 * operand2;
        break;
      case '÷':
        correctAnswer = operand1 ~/ operand2;
        break;
    }

    // Return the correct answer
    return correctAnswer;
  }

  // Method to calculate the correct answer for a given problem
  static int calculateCorrectAnswer(String problem) {
    // Split the problem string into operands and operator
    List<String> parts = problem.split(' ');
    int operand1 = int.parse(parts[0]);
    int operand2 = int.parse(parts[2]);
    String operator = parts[1];
    int correctAnswer = 0;

    // Calculate the correct answer based on the operator
    switch (operator) {
      case '+':
        correctAnswer = operand1 + operand2;
        break;
      case '-':
        correctAnswer = operand1 - operand2;
        break;
      case '×':
        correctAnswer = operand1 * operand2;
        break;
      case '÷':
        correctAnswer = operand1 ~/ operand2;
        break;
    }

    // Return the correct answer
    return correctAnswer;
  }
}
