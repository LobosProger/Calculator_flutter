import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorModel extends Cubit {
  CalculatorModel(String initialState) : super(initialState) {
    currentShowableNumberOnPanel = initialState;
  }

  int valueA = 0;
  int valueB = 0;
  String selectedOperandToCalculateResult = "";
  String currentShowableNumberOnPanel = "0";

  void enterNumber(int number) {
    if (number != 0 || !isNumberOnPanelIsZero()) {
      if (isNumberOnPanelIsZero()) {
        currentShowableNumberOnPanel = "";
      }

      currentShowableNumberOnPanel += number.toString();
      updateView();
    }
  }

  void clickOperand(String signOfOperand) {
    if (signOfOperand == "C") {
      clearNumberView();
    } else if (signOfOperand == "=") {
      calculateValueAndShowResult();
    } else {
      assignOperandAndClearNumberView(signOfOperand);
    }
  }

  void calculateValueAndShowResult() {
    switch (selectedOperandToCalculateResult) {
      case "+":
        valueB = int.parse(currentShowableNumberOnPanel);
        currentShowableNumberOnPanel = (valueA + valueB).toString();
        updateView();
        break;

      case "-":
        valueB = int.parse(currentShowableNumberOnPanel);
        currentShowableNumberOnPanel = (valueA - valueB).toString();
        updateView();
        break;

      case "X":
        valueB = int.parse(currentShowableNumberOnPanel);
        currentShowableNumberOnPanel = (valueA * valueB).toString();
        updateView();
        break;

      case "/":
        valueB = int.parse(currentShowableNumberOnPanel);
        currentShowableNumberOnPanel = (valueA ~/ valueB).toString();
        updateView();
        break;

      case "%":
        valueB = int.parse(currentShowableNumberOnPanel);
        currentShowableNumberOnPanel = (valueA / 100 * valueB).toString();
        updateView();
        break;

      default:
        break;
    }
  }

  void clearNumberView() {
    currentShowableNumberOnPanel = "0";
    updateView();
  }

  void assignOperandAndClearNumberView(String operand) {
    selectedOperandToCalculateResult = operand;
    valueA = int.parse(currentShowableNumberOnPanel);
    currentShowableNumberOnPanel = "0";
    updateView();
  }

  bool isNumberOnPanelIsZero() => currentShowableNumberOnPanel == "0";

  void updateView() => emit(currentShowableNumberOnPanel);

  String getShowableValueForView() => currentShowableNumberOnPanel;
}
