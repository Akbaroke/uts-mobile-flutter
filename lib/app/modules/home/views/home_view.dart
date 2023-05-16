import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts_mobile/app/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import 'package:uts_mobile/app/utils/global.colors.dart';

final authC = Get.find<AuthController>();

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // ubah warna background appbar
        actions: [
          IconButton(
              color: GlobalColors.textPrimaryColor,
              onPressed: () => authC.logout(),
              icon: const Icon(Icons.logout))
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                alignment: Alignment.center,
                // ignore: sort_child_properties_last
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/sample_home.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome Home",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: GlobalColors.textPrimaryColor,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
