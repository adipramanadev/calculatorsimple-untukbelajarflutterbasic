import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Sederhana',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _input = "";

  void onPressed(String button) {
    setState(() {
      if (button == "=") {
        _output = hitung(_input);
        _input = _output;
      } else {
        _input += button;
      }
    });
  }

  String hitung(String input) {
    try {
      String sanitizedInput = input.replaceAll("x", "*").replaceAll(":", "/");
      // Using RegExp to extract numbers and operators
      RegExp regExp = RegExp(r"(\d+\.?\d*)([+\-*/])");
      Iterable<Match> matches = regExp.allMatches(sanitizedInput);
      if (matches.isEmpty) {
        return input; // No valid expression found
      }
      double result = double.parse(matches.first.group(1)!);
      for (Match match in matches) {
        double num = double.parse(match.group(1)!);
        String operator = match.group(2)!;
        if (operator == "+") {
          result += num;
        } else if (operator == "-") {
          result -= num;
        } else if (operator == "*") {
          result *= num;
        } else if (operator == "/") {
          if (num != 0) {
            result /= num;
          } else {
            return "Error"; // Division by zero
          }
        }
      }
      return result.toString();
    } catch (e) {
      return "Error"; // Invalid expression
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator Sederhana"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            margin: const EdgeInsets.all(10.0),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(_input, style: TextStyle(fontSize: 25)),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("+"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("x"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("0"),
                  _buildButton("."),
                  _buildButton("="),
                  _buildButton("/"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      width: 80.0,
      height: 80.0,
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        child: Text(text),
      ),
    );
  }
}
