import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calculator/pages/home.dart';

//Widget Test
void main() {
  testWidgets("HomePage", (WidgetTester tester) async {
    //先用pumpWidget来render将要被测试HomePage
    //由于在HomePage中使用ScreenUtil, 所以这里也需要ScreenUtilInit来包裹一下
    await tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(480, 854),
      builder: () => const MaterialApp(
        home: HomePage(),
      ),
    ));
    //测试包含0的Text组件有2个: 按键0和初始显示0的结果区域
    expect(find.text("0"), findsNWidgets(2));
    //测试包含1至9的Text组件各有1个
    for (int i = 1; i <= 9; i++) {
      expect(find.text("$i"), findsOneWidget);
    }
    //测试包含"+", "-", "*", "/", ".", "=", "C", "_<"的Text组件各有一个
    for (String str in ["+", "-", "*", "/", ".", "=", "C", "_<"]) {
      expect(find.text(str), findsOneWidget);
    }
  });
}
