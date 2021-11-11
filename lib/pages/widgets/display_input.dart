import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calculator/controllers/calculator.dart';

//显示当前已经输入的内容
class DisplayInput extends StatelessWidget {
  const DisplayInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<Calculator>(
        builder: (_) => Text(
          _.inputs,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.r,
          ),
        ),
      ),
    );
  }
}
