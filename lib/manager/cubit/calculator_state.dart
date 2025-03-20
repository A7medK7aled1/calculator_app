part of 'calculator_cubit.dart';

@immutable
sealed class CalculatorState {}

final class CalculatorInitial extends CalculatorState {
  final String displayText;
  CalculatorInitial(this.displayText);
}

class CalculatorResult extends CalculatorState {
  final String result;
  CalculatorResult(this.result);
}

class CalculatorError extends CalculatorState {
  final String errorMessage;
  CalculatorError(this.errorMessage);
}
