import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'arithmetic_drills_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arithmetic Drills App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/arithmetic_drills': (context) => ArithmeticDrillsScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellowAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Welcome to Arithmetic Drills!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/images.jpeg',
                    fit: BoxFit.contain,
                    width: 400,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 40,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/arithmetic_drills');
                      },
                      child: Text(
                        'Start Drills',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                      height:
                          10), // Adding spa0cing below the "Start Drills" button
                  TextButton(
                    onPressed: () {
                      // Navigate to Khan Academy website

                      launch('https://www.khanacademy.org/math/arithmetic');
                    },
                    child: Text(
                      'Learn More',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
