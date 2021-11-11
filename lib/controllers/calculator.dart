import 'package:get/get.dart';

class Calculator extends GetxController {
  //定义正则表达式用来校验按键输入是否是运算符
  final RegExp _regExp = RegExp(r"([+]|[-]|[*]|[/])");
  //结果区域显示的内容
  //计算过程中, 显示的是输入的最后一组数字
  //计算后, 显示的是计算结果
  String result = "0";
  //已录入的按键输入
  //数字和运算符分开保存
  //如: ["123", "+", "0.456"]
  List<String> _inputs = [];

  //以字符串的形式返回已录入的按键输入
  String get inputs => _inputs.join(" ");

  //当按下按键
  void pressButton(String buttonText) {
    if (buttonText == "=") {
      _calculate();
    } else if (buttonText == "C") {
      _deleteAll();
    } else if (buttonText == "_<") {
      _deleteOne();
    } else {
      _validate(buttonText);
    }
  }

  //当按下"="键时计算结果
  void _calculate() {
    //如果最后录入的是运算符或者0或者数字小数点后没有输入小数位, 则不计算结果
    if (_isOperator(_inputs.last) ||
        _isZero(_inputs.last) ||
        _inputs.last.endsWith(".")) return;
    //先计算乘除
    //碰上运算符, 则计算运算符左右两边运算的结果
    //把结果保存到左边的数字, 再移除运算符以及右边的数字
    //最后把counter i减1
    // 1 + 2 * 3 - 1
    //       ^       i = 3
    // 1 + 6 - 1
    //     ^       i = 2
    for (int i = 0; i < _inputs.length; i++) {
      if (_inputs[i] == "*") {
        _inputs[i - 1] =
            "${double.parse(_inputs[i - 1]) * double.parse(_inputs[i + 1])}";
        _inputs.removeAt(i);
        _inputs.removeAt(i);
        i--;
      } else if (_inputs[i] == "/") {
        _inputs[i - 1] =
            "${double.parse(_inputs[i - 1]) / double.parse(_inputs[i + 1])}";
        _inputs.removeAt(i);
        _inputs.removeAt(i);
        i--;
      }
    }
    //再计算加减
    for (int i = 0; i < _inputs.length; i++) {
      if (_inputs[i] == "+") {
        _inputs[i - 1] =
            "${double.parse(_inputs[i - 1]) + double.parse(_inputs[i + 1])}";
        _inputs.removeAt(i);
        _inputs.removeAt(i);
        i--;
      } else if (_inputs[i] == "-") {
        _inputs[i - 1] =
            "${double.parse(_inputs[i - 1]) - double.parse(_inputs[i + 1])}";
        _inputs.removeAt(i);
        _inputs.removeAt(i);
        i--;
      }
    }
    //最后的计算结果如果小数位是0, 则去掉小数点和小数位
    result = _inputs[0].endsWith(".0")
        ? _inputs[0].substring(0, _inputs[0].length - 2)
        : _inputs[0];
    _inputs = [result];
    //刷新页面的显示
    update();
  }

  //当按下"C"键时, 清除已输入的内容并复位结果
  void _deleteAll() {
    _inputs = [];
    result = "0";
    //刷新页面的显示
    update();
  }

  //当按下"_<"键时, 删除已输入的内容的最后一位
  void _deleteOne() {
    if (_inputs.isNotEmpty) {
      //如果当前最后录入的是运算符, 就直接删除
      if (_isOperator(_inputs.last)) {
        _inputs.removeLast();
        //此时, 结果区域应该显示的是最后录入的那组数字
        result = _inputs.last;
      }
      //如果当前最后录入的是数字, 则删除数字的最后一位
      else {
        result = _inputs.last.substring(0, _inputs.last.length - 1);
        //删除后如果数字为空, 则移除该数字, 并将显示的结果变为0, 等待新数字的输入
        if (result.isEmpty) {
          _inputs.removeLast();
          result = "0";
        } else {
          _inputs.last = result;
        }
      }
      //刷新页面的显示
      update();
    }
  }

  //当按下除"=","C","_<"以外的按键时, 校验按键的输入
  void _validate(String input) {
    //当本次输入是首次输入时或当已录入的内容最后一条是运算符时
    //如果本次输入的是运算符, 则本次输入无效
    //如果本次输入的是".", 则新增一条录入内容"0."
    //如果本次输入的是数字, 则新增一条录入内容为本次输入的数字
    if (_inputs.isEmpty || _isOperator(_inputs.last)) {
      if (!_isOperator(input)) {
        result = input == "." ? "0." : input;
        _inputs.add(result);
      }
    }
    //当已录入的内容最后一条不是运算符时
    else {
      //当本次输入的是运算符时
      //如果已录入的内容最后一条是0或者小数点后还没有输入数字, 则本次输入的运算符无效
      //否则新增一条录入内容为本次输入的运算符
      if (_isOperator(input)) {
        if (!_isZero(_inputs.last) && !_inputs.last.endsWith(".")) {
          _inputs.add(input);
          //将运算符录入后, 将显示的结果变为0, 等待新数字的输入
          result = "0";
        }
      }
      //当本次输入的不是运算符时
      //如果本次输入是".", 要避免已录入的内容最后一条中已经有"."
      //如果本次输入是数字, 则直接添加到已录入的内容最后一条的末尾
      else {
        if (input != "." || !_inputs.last.contains(".")) {
          result = _inputs.last + input;
          //去掉数字开头不必要的0
          if (result.startsWith("0") && !result.startsWith("0.")) {
            result = result.substring(1);
          }
          _inputs.last = result;
        }
      }
    }
    //刷新页面的显示
    update();
  }

  //判断是不是运算符
  bool _isOperator(String text) {
    return text.length == 1 && _regExp.hasMatch(text);
  }

  //判断是否是0
  //把字符串中的"."和"0"都去掉后,如果字符串变为空, 就是0
  bool _isZero(String text) {
    return text.replaceFirst(".", "").replaceAll("0", "").isEmpty;
  }
}
