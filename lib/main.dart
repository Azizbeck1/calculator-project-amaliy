import 'package:flutter/material.dart';
import 'logic.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0'; // Ekrandagi matn
  String expression = ''; // Hisoblash uchun ifoda

  void onButtonPressed(String value) {
  setState(() {
    if (value == 'C') {
      // Tozalash
      displayText = '0';
      expression = '';
    } else if (value == '=') {
      // Hisoblash
      try {
        double result = CalculatorLogic.evaluateExpression(expression);
        displayText = result.toString();
        expression = result.toString(); // Keyingi hisob uchun tayyorlash
      } catch (e) {
        displayText = 'Error';
        expression = '';
      }
    } else if (value == '.') {
      // Nuqta tugmasini boshqarish
      if (!expression.endsWith('.') &&
          (expression.isEmpty || !expression.split(RegExp(r'[+\-]')).last.contains('.'))) {
        expression += value;
        displayText += value;
      }
    } else if (value == '+' || value == '-') {
      // Amallarni boshqarish
      if (expression.isNotEmpty &&
          !expression.endsWith('+') &&
          !expression.endsWith('-')) {
        expression += value;
        displayText += value;
      }
    } else {
      // Raqamlar va boshqa belgilarning oddiy qo'shilishi
      if (displayText == '0' && value != '.') {
        displayText = value;
        expression = value;
      } else {
        displayText += value;
        expression += value;
      }
    }
  });
}


  Widget buildButton(String value, Color textColor) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () => onButtonPressed(value),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(40.0),
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.centerLeft,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: Text(
              displayText,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('1', Colors.black),
                  buildButton('2', Colors.black),
                  buildButton('3', Colors.black),
                  buildButton('C', Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('4', Colors.black),
                  buildButton('5', Colors.black),
                  buildButton('6', Colors.black),
                  buildButton('+', Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton('7', Colors.black),
                  buildButton('8', Colors.black),
                  buildButton('9', Colors.black),
                  buildButton('-', Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 70),
                  buildButton('0', Colors.black),
                  buildButton('.', Colors.red),
                  buildButton('=', Colors.red),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
