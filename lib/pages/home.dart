import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:calculator/pages/widgets/display_input.dart';
import 'package:calculator/pages/widgets/display_result.dart';
import 'package:calculator/pages/widgets/button_area.dart';
import 'package:calculator/controllers/calculator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //初始化Calculator Controller
    Get.put(Calculator());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h, bottom: 15.h),
        child: Column(
          children: const [
            //显示当前已输入的内容, 占屏1/5
            Expanded(flex: 1, child: DisplayInput()),
            //显示计算结果, 占屏1/5
            Expanded(flex: 1, child: DisplayResult()),
            //按键区域, 占屏3/5
            Expanded(flex: 3, child: ButtonArea()),
          ],
        ),
      ),
    );
  }
}
