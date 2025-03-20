import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial('0'));

  String _input = '';
  String _operator = '';
  double? _firstNumber;

  void onButtonPressed(String value) {
    if (value == 'C') {
      _clear();
    } else if (value == '=') {
      _calculateResult();
    } else if (_isOperator(value)) {
      _setOperator(value);
    } else {
      _appendNumber(value);
    }
  }

  void _clear() {
    _input = '';
    _operator = '';
    _firstNumber = null;
    emit(CalculatorInitial('0'));
  }

  bool _isOperator(String value) {
    return ['+', '-', '*', '/'].contains(value);
  }

  void _setOperator(String operator) {
    if (_input.isNotEmpty) {
      _firstNumber = double.tryParse(_input);
      _operator = operator;
      _input = '';
    }
  }

  void _appendNumber(String value) {
    if (value == '.' && _input.contains('.')) return; // منع أكتر من نقطة
    _input += value;
    emit(CalculatorInitial(_input));
  }

  void _calculateResult() {
    if (_firstNumber == null || _input.isEmpty) return;
    double secondNumber = double.tryParse(_input) ?? 0.0;

    double result;
    try {
      switch (_operator) {
        case '+':
          result = _firstNumber! + secondNumber;
          break;
        case '-':
          result = _firstNumber! - secondNumber;
          break;
        case '*':
          result = _firstNumber! * secondNumber;
          break;
        case '/':
          if (secondNumber == 0) throw Exception("Division by zero");
          result = _firstNumber! / secondNumber;
          break;
        default:
          emit(CalculatorError("Invalid Operator"));
          return;
      }
      emit(CalculatorResult(result.toString()));
      _clear();
    } catch (e) {
      emit(CalculatorError(e.toString()));
    }
  }
}
