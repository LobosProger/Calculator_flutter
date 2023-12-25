import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/CalculatorLogic.dart';

void main() {
  runApp(BlocProvider(create: (BuildContext context) => CalculatorModel("0"), child: MaterialAppPage()));
}

class MaterialAppPage extends StatelessWidget {
  const MaterialAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calculate,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Calculator",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: const CalculatorPanel(),
    );
  }
}

class CalculatorPanel extends StatelessWidget {
  const CalculatorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final calculatorModel = context.watch<CalculatorModel>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 70,
            child: Card(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                    calculatorModel.getShowableValueForView(),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberButton(
              number: 1,
            ),
            NumberButton(
              number: 2,
            ),
            NumberButton(
              number: 3,
            ),
            OperandButton(
              operand: "+",
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberButton(
              number: 4,
            ),
            NumberButton(
              number: 5,
            ),
            NumberButton(
              number: 6,
            ),
            OperandButton(
              operand: "-",
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberButton(
              number: 7,
            ),
            NumberButton(
              number: 8,
            ),
            NumberButton(
              number: 9,
            ),
            OperandButton(
              operand: "X",
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OperandButton(
              operand: "C",
            ),
            NumberButton(
              number: 0,
            ),
            OperandButton(
              operand: "=",
            ),
            OperandButton(
              operand: "/",
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              child: OperandButton(
                operand: "%",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  const NumberButton({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final calculatorEventModel = context.read<CalculatorModel>();
    return Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
            onPressed: () => calculatorEventModel.enterNumber(number),
            child: Text(
              "$number",
              style: const TextStyle(fontSize: 20),
            )));
  }
}

class OperandButton extends StatelessWidget {
  final String operand;
  const OperandButton({super.key, required this.operand});

  @override
  Widget build(BuildContext context) {
    final calculatorEventModel = context.read<CalculatorModel>();
    return Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
            onPressed: () => calculatorEventModel.clickOperand(operand),
            child: Text(
              operand,
              style: const TextStyle(fontSize: 20),
            )));
  }
}
