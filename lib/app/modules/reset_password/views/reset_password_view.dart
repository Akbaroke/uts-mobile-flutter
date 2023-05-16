import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts_mobile/app/controllers/auth_controller.dart';
import '../controllers/reset_password_controller.dart';
import 'package:uts_mobile/app/utils/global.colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final authC = Get.find<AuthController>();

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // ubah warna background appbar
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: GlobalColors.textPrimaryColor), // ubah warna ikon
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Image(
                      height: 200,
                      image: AssetImage("assets/images/storyset_forgot.png")),
                ),
                Text(
                  'Forgot\nPassword ?',
                  style: TextStyle(
                    color: GlobalColors.textPrimaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  'Don`t worry! It happens. Please enter the address associated with your account.',
                  style: TextStyle(
                      color: GlobalColors.textSecondaryColor,
                      fontSize: 14,
                      height: 1.4),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.at,
                      size: 20,
                      color: GlobalColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller.emailC,
                        style: TextStyle(
                            fontSize: 16,
                            color: GlobalColors.textSecondaryColor),
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () => authC.resetPassword(controller.emailC.text),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        GlobalColors.mainColor),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
