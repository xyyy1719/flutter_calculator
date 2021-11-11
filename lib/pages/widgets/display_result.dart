import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calculator/controllers/calculator.dart';

//显示结果的区域
class DisplayResult extends StatelessWidget {
  const DisplayResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //结果显示在区域的右下角
      alignment: const Alignment(0.9, 0.9),
      //从Calculator Controller中读取result变量值并显示
      child: GetBuilder<Calculator>(
        builder: (_) => Text(
          _.result,
          style: TextStyle(color: Colors.white, fontSize: 64.r),
        ),
      ),
    );
  }
}
