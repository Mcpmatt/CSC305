import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const SimpleCalculatorApp());
}

class SimpleCalculatorApp extends StatelessWidget {
  const SimpleCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
           // Check for division by zero
          if (_expression.contains('/0')) {
            _result = ' Error: Division by zero';
          } else {
            final expression = Expression.parse(_expression);
            const evaluator = ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _result = ' = $result';
          }
        } catch (e) {
          _result = ' Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value, {Color? color, Color textColor = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(value),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey,
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 24.0, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Simple Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  '$_expression$_result',
                  style: const TextStyle(fontSize: 32.0, color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', color: Colors.grey[800]),
                    _buildButton('8', color: Colors.grey[800]),
                    _buildButton('9', color: Colors.grey[800]),
                    _buildButton('/', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', color: Colors.grey[800]),
                    _buildButton('5', color: Colors.grey[800]),
                    _buildButton('6', color: Colors.grey[800]),
                    _buildButton('*', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', color: Colors.grey[800]),
                    _buildButton('2', color: Colors.grey[800]),
                    _buildButton('3', color: Colors.grey[800]),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', color: Colors.grey[800]),
                    _buildButton('C', color: Colors.red),
                    _buildButton('=', color: Colors.green),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}