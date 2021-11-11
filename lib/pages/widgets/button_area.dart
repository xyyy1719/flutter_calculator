import 'package:calculator/pages/widgets/button.dart';
import 'package:flutter/material.dart';

//按键区域
class ButtonArea extends StatelessWidget {
  const ButtonArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //定义三种按键的颜色
    final Color operatorColor = Colors.amber;
    final Color functionColor = Colors.grey;
    final Color numberColor = Colors.grey.shade800;

    return Column(
      children: [
        //第一行
        Expanded(
          child: Row(
            children: [
              Button(text: "C", color: functionColor, flex: 2),
              Button(text: "_<", color: functionColor),
              Button(text: "/", color: operatorColor),
            ],
          ),
        ),
        //第二行
        Expanded(
          child: Row(
            children: [
              Button(text: "7", color: numberColor),
              Button(text: "8", color: numberColor),
              Button(text: "9", color: numberColor),
              Button(text: "*", color: operatorColor),
            ],
          ),
        ),
        //第三行
        Expanded(
          child: Row(
            children: [
              Button(text: "4", color: numberColor),
              Button(text: "5", color: numberColor),
              Button(text: "6", color: numberColor),
              Button(text: "-", color: operatorColor),
            ],
          ),
        ),
        //第四行
        Expanded(
          child: Row(
            children: [
              Button(text: "1", color: numberColor),
              Button(text: "2", color: numberColor),
              Button(text: "3", color: numberColor),
              Button(text: "+", color: operatorColor),
            ],
          ),
        ),
        //第五行
        Expanded(
          child: Row(
            children: [
              Button(text: "0", color: numberColor, flex: 2),
              Button(text: ".", color: numberColor),
              Button(text: "=", color: operatorColor),
            ],
          ),
        )
      ],
    );
  }
}
