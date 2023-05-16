import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uts_mobile/app/controllers/auth_controller.dart';
import 'package:uts_mobile/app/routes/app_pages.dart';
import 'package:uts_mobile/app/utils/global.colors.dart';
import '../controllers/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final authC = Get.find<AuthController>();

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 240,
                      image: AssetImage("assets/images/storyset_login.png")),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: GlobalColors.textPrimaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.lock,
                      size: 20,
                      color: GlobalColors.textSecondaryColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller.passC,
                        obscureText: true,
                        style: TextStyle(
                            fontSize: 16,
                            color: GlobalColors.textSecondaryColor),
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                      child: Text(
                        'Forgot password ?',
                        style: TextStyle(
                          fontSize: 13,
                          color: GlobalColors.mainColor,
                        ),
                      )),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    authC.login(controller.emailC.text, controller.passC.text);
                    print(controller.emailC.text + controller.passC.text);
                  },
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
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account ?"),
                    TextButton(
                        onPressed: () => Get.offNamed(Routes.SIGNUP),
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            color: GlobalColors.mainColor,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
