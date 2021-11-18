import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/controllers/calculator.dart';

//Unit Test
void main() {
  late Calculator calc;

  //执行每个测试之前都重新初始化Calculator类
  setUp(() {
    calc = Calculator();
  });

  test('add', () {
    calc.pressButton("1");
    calc.pressButton("+");
    calc.pressButton("2");
    calc.pressButton("=");
    expect(calc.result, "3");
  });

  test('complex', () {
    calc.pressButton("10");
    calc.pressButton("+");
    calc.pressButton("24");
    calc.pressButton("*");
    calc.pressButton("5");
    calc.pressButton("-");
    calc.pressButton("34");
    expect(calc.inputs, "10 + 24 * 5 - 34");
    calc.pressButton("=");
    expect(calc.result, "96");
  });
}
