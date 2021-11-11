import 'package:calculator/controllers/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//计算器的按键组件
class Button extends StatelessWidget {
  //按键上的显示文字
  final String text;
  //按键的颜色
  final Color color;
  //按键的宽度, 默认flex = 1
  final int? flex;

  const Button({
    Key? key,
    required this.text,
    required this.color,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //取得已经在home页上初始化的Calculator Controller
    Calculator _calculator = Get.find();

    return Expanded(
      flex: flex!,
      child: InkWell(
        //当按下按键时调用定义在Calculator Controller中的pressButton方法
        onTap: () => _calculator.pressButton(text),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 10,
                color: color.withOpacity(0.6),
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 40.r),
            ),
          ),
        ),
      ),
    );
  }
}
