import 'package:flutter/material.dart';
import 'package:uts_mobile/app/utils/global.colors.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: GlobalColors.mainColor,
          body: Center(child: CircularProgressIndicator())),
    );
  }
}
