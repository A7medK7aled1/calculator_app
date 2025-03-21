import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial('0'));
  String display = '';
  String firstNumber = '';
  String secondNumber = '';
  String operation = '';

  void onButtonPressed(String number) {
    if (number == '=') {
      calculateResult();
    } else if (number == '+' ||
        number == '/' ||
        number == '-' ||
        number == '*') {
      operationPressed(number);
    } else if (number == 'C') {
      _clear();
    } else {
      display += number;

      emit(CalculatorInitial(display));
    }
  }

  void operationPressed(String op) {
    if (display.isNotEmpty) {
      firstNumber = display;
      operation = op;
      display = '';
      String value = firstNumber + operation;
      emit(CalculatorInitial(value));
    }
  }

  void calculateResult() {
    if (firstNumber.isNotEmpty && display.isNotEmpty) {
      secondNumber = display;
      double num1 = double.parse(firstNumber);
      double num2 = double.parse(secondNumber);
      double result = 0;

      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            display = 'Error';
            emit(CalculatorInitial(display));
            return;
          }
          break;
      }
      display = result.toString();
      emit(CalculatorInitial(display));
    }
  }

  void _clear() {
    display = '';
    firstNumber = '';
    secondNumber = '';
    operation = '';
    emit(CalculatorInitial('0'));
  }
}
