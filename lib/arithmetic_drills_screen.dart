import 'package:flutter/material.dart'; // Import the material package for Flutter UI components
import 'arithmetic_logic.dart'; // Import the arithmetic_logic.dart file containing the logic
import 'dart:async'; // Import the async package for working with asynchronous operations

class ArithmeticDrillsScreen extends StatefulWidget {
  @override
  _ArithmeticDrillsScreenState createState() =>
      _ArithmeticDrillsScreenState(); // Create a stateful widget for the arithmetic drills screen
}

class _ArithmeticDrillsScreenState extends State<ArithmeticDrillsScreen> {
  late List<String> problems; // List to store arithmetic problems
  late int currentProblemIndex; // Index to track the current problem
  String userAnswer =
      ''; // Initialize userAnswer as an empty string to store user input
  TextEditingController answerController =
      TextEditingController(); // Controller for the TextField to capture user input
  int correctAnswers = 0; // Initialize the number of correct answers
  late Timer questionTimer; // Timer variable to track question time
  int remainingTime = 10; // Initial time for each question in seconds

  late FocusNode
      answerFocusNode; // Define FocusNode for the answer TextField to handle focus

  @override
  void initState() {
    super.initState();
    // Generate 10 arithmetic problems
    problems =
        List<String>.generate(10, (index) => ArithmeticLogic.generateProblem());
    currentProblemIndex = 0; // Start with the first problem

    answerFocusNode = FocusNode(); // Initialize FocusNode
    answerFocusNode.requestFocus(); // Focus on the answer field initially

    startQuestionTimer(); // Start the timer when the screen initializes
  }

  @override
  void dispose() {
    // Dispose FocusNode when the widget is disposed to avoid memory leaks
    answerFocusNode.dispose();
    questionTimer.cancel(); // Cancel the timer when disposing of the widget
    super.dispose();
  }

  void startQuestionTimer() {
    // Start the timer for each question
    questionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          // Time's up, move to the next question or submit the current one
          submitAnswer();
        }
      });
    });
  }

  void resetQuestionTimer() {
    // Reset the timer for each new question
    setState(() {
      remainingTime = 10;
    });
  }

  void submitAnswer() {
    // Submit the answer and move to the next question
    questionTimer.cancel(); // Cancel the timer when the answer is submitted

    // Calculate the correct answer based on the problem
    int correctAnswer =
        ArithmeticLogic.calculateCorrectAnswer(problems[currentProblemIndex]);

    // Compare userAnswer with the correct answer
    bool isCorrect = userAnswer == correctAnswer.toString();

    // Show feedback dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect
            ? 'Correct!'
            : 'Incorrect!'), // Display the result of the answer
        content: Text(
          isCorrect
              ? 'Congratulations! Your answer is correct.'
              : 'Oops! Your answer is incorrect. The correct answer is $correctAnswer.', // Display the feedback message
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              setState(() {
                if (isCorrect) {
                  correctAnswers++; // Increment the count of correct answers
                }
                if (currentProblemIndex < problems.length - 1) {
                  // Move to the next question
                  currentProblemIndex++;
                  userAnswer =
                      ''; // Clear the user's answer for the new question
                  resetQuestionTimer(); // Reset the timer for the new question
                  startQuestionTimer(); // Start the timer for the new question
                } else {
                  // All questions answered, show a dialog or navigate to a new screen
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                          'Quiz Completed'), // Display quiz completion message
                      content: Text(
                        'You answered $correctAnswers out of ${problems.length} questions correctly.', // Display the quiz results
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Restart the drill
                            restartDrill();
                          },
                          child: Text(
                            'Restart Drill', // Button to restart the drill
                            style: TextStyle(
                              color: Colors.green, // Set text color to green
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context)
                                .pop(); // Close the quiz screen
                          },
                          child: Text(
                            'Exit', // Button to exit the quiz
                            style: TextStyle(
                              color: Colors.red, // Set text color to red
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
            child: Text('OK'), // Button to close the dialog
          ),
        ],
      ),
    );

    // Clear the user's answer
    setState(() {
      userAnswer = '';
    });

    // Clear the text field and reset focus
    clearTextFieldAndFocus();
  }

  void restartDrill() {
    setState(() {
      // Reset all variables for a new drill
      problems = List<String>.generate(
          10, (index) => ArithmeticLogic.generateProblem());
      currentProblemIndex = 0;
      correctAnswers = 0;
    });
    resetQuestionTimer();
    startQuestionTimer();
  }

  void clearTextFieldAndFocus() {
    // Clear the text field
    answerController.clear();

    // Reset focus
    FocusScope.of(context).requestFocus(answerFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    String currentProblem = problems[currentProblemIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arithmetic Drills', // Set the app bar title
          style: TextStyle(
            color: Colors.purpleAccent, // Set text color to purple
            fontWeight: FontWeight.bold, // Set font weight to bold
            fontSize: 24, // Set font size
          ),
        ),
        backgroundColor:
            Colors.yellowAccent, // Set app bar background color to yellow
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Set the icon to the back arrow
            color: Colors.purpleAccent, // Set icon color to purple
            size: 30, // Set icon size
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 50), // Adjust the bottom margin
              child: Center(
                child: Text(
                  currentProblem, // Display the current arithmetic problem
                  style: TextStyle(
                    fontFamily: 'Montserrat', // Set font family
                    fontSize: 100, // Set font size
                    color: Colors.purpleAccent, // Set text color to purple
                    fontWeight: FontWeight.bold, // Set font weight to bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200, // Set width of circular container
                  height: 200, // Set height of circular container
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Make the container circular
                    color: Colors.yellow, // Set background color to yellow
                  ),
                ),
                Column(
                  children: [
                    TextField(
                      autofocus: true, // Automatically focus the TextField
                      controller:
                          answerController, // Assign the controller to the TextField
                      onChanged: (value) {
                        setState(() {
                          userAnswer =
                              value; // Update userAnswer with the entered value
                        });
                      },
                      keyboardType:
                          TextInputType.number, // Set keyboard type to number
                      focusNode:
                          answerFocusNode, // Assign FocusNode to the TextField
                      style: TextStyle(
                        color: Colors.purple, // Set text color to purple
                        fontSize: 24, // Set font size
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Remove border
                        hintText: '', // Set hint text to empty string
                        hintStyle: TextStyle(
                          color: Colors.blue, // Set hint text color to blue
                          fontSize: 24, // Set font size of hint text
                        ),
                        alignLabelWithHint: true, // Center the hint text
                      ),
                      textAlign:
                          TextAlign.center, // Center the user's answer text
                    ),
                    SizedBox(height: 10), // Add spacing
                    Text(
                      'Enter answer', // Display text prompting the user to enter an answer
                      style: TextStyle(
                        color: Colors.purpleAccent, // Set text color to purple
                        fontSize: 24, // Set font size
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20), // Add spacing
            Text(
              'Time Left: $remainingTime seconds', // Display remaining time
              style: TextStyle(
                color: Colors.blue, // Set text color to blue
                fontSize: 18, // Set font size
              ),
            ),
            SizedBox(height: 20), // Add spacing
            ElevatedButton(
              onPressed: () {
                submitAnswer(); // Call the submitAnswer function when button is pressed
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors
                    .yellowAccent), // Set button background color to yellow
              ),
              child: Text(
                'Submit', // Display text on the button
                style: TextStyle(
                  color: Colors.deepPurple, // Set text color to deep purple
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
