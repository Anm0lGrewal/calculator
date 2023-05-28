// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCalculator(),
    ),
  );
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  // variables
  var input = '';
  var output = '';
  var operation = '';

  // calculator operations
  onClickButton(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = userInput.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + value;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(left: 7, right: 7),
        child: Column(
          children: [
            Expanded(
              // this is the area where the answer is displayed.
              child: Container(
                color: Colors.black,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(height: 90),
                    Text(
                      output,
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            // this is the area of buttons.
            Row(
              children: [
                button(
                    text: 'AC', tColor: oragneColor, bgColor: operatcorColor),
                button(text: '<', tColor: oragneColor, bgColor: operatcorColor),
                button(text: '', bgColor: Colors.transparent),
                button(text: '/', bgColor: operatcorColor),
              ],
            ),
            Row(
              children: [
                button(text: '7'),
                button(text: '8'),
                button(text: '9'),
                button(text: 'x', bgColor: operatcorColor),
              ],
            ),
            Row(
              children: [
                button(text: '4'),
                button(text: '5'),
                button(text: '6'),
                button(text: '-', bgColor: operatcorColor),
              ],
            ),
            Row(
              children: [
                button(text: '1'),
                button(text: '2'),
                button(text: '3'),
                button(text: '+', bgColor: operatcorColor),
              ],
            ),
            Row(
              children: [
                button(text: '%', tColor: oragneColor),
                button(text: '0'),
                button(text: '.'),
                button(text: '=', bgColor: oragneColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({text, tColor = Colors.white, bgColor = buttonColor, icon}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            primary: bgColor,
            padding: EdgeInsets.all(22),
          ),
          onPressed: () => onClickButton(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
