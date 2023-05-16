import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uts_mobile/app/routes/app_pages.dart';
import 'package:uts_mobile/app/utils/global.colors.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Success",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText:
              "We have sent a link to reset your password to your email\n$email.",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Failed Error",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "Error, network error or others!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } else {
      Get.defaultDialog(
        title: "Failed",
        radius: 15,
        titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        middleText: "Error, invalid e-mail!",
        middleTextStyle: TextStyle(
          color: GlobalColors.textSecondaryColor,
          fontSize: 14,
          height: 1.3,
        ),
        confirm: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // ubah nilai radius disini
              ),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Ok",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (myUser.user!.emailVerified) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Verification Email",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
          middleText:
              "Please Verify your email first!  Do you want to be sent a re-verification ?",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () async {
              await myUser.user!.sendEmailVerification();
              Get.back();
            },
            child: const Text(
              "Ya, Resend",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          cancel: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  color: Colors.grey, // warna border outline
                  width: 1.0, // lebar border outline
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 12,
                color: GlobalColors.textPrimaryColor,
              ),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Not user found for that email.');
        Get.defaultDialog(
          title: "Failed",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "Not user found for that email!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Failed",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "Wrong password provided for that user!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Failed Error",
        radius: 15,
        titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        middleText: "Error, network error or others!",
        middleTextStyle: TextStyle(
          color: GlobalColors.textSecondaryColor,
          fontSize: 14,
          height: 1.3,
        ),
        confirm: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // ubah nilai radius disini
              ),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Ok",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void signup(String email, String password, String password2) async {
    try {
      if (password != password2) {
        print('passwords are not the same.');
        Get.defaultDialog(
          title: "Failed",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "passwords are not the same!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        UserCredential myUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await myUser.user!.sendEmailVerification();
        Get.defaultDialog(
          title: "Verification Email",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
          middleText: "We have sent a verification link to your email\n$email.",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          onConfirm: () {
            Get.back(); // close dialog
            Get.back(); // go to login
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.defaultDialog(
          title: "Failed",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "The password provided is too weak!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.defaultDialog(
          title: "Failed",
          radius: 15,
          titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          middleText: "The account already exists for that email!",
          middleTextStyle: TextStyle(
            color: GlobalColors.textSecondaryColor,
            fontSize: 14,
            height: 1.3,
          ),
          confirm: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // ubah nilai radius disini
                ),
              ),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Ok",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Failed Error",
        radius: 15,
        titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        middleText: "Error, network error or others!",
        middleTextStyle: TextStyle(
          color: GlobalColors.textSecondaryColor,
          fontSize: 14,
          height: 1.3,
        ),
        confirm: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // ubah nilai radius disini
              ),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Ok",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void logout() async {
    Get.defaultDialog(
      title: "Logout",
      radius: 15,
      titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      middleText: "Are you sure you want to logout ?",
      middleTextStyle: TextStyle(
        color: GlobalColors.textSecondaryColor,
        fontSize: 14,
        height: 1.3,
      ),
      confirm: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // ubah nilai radius disini
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        onPressed: () async {
          Get.back();
          await FirebaseAuth.instance.signOut();
          Get.offNamed(Routes.LOGIN);
        },
        child: const Text(
          "Ya, Logout",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
      cancel: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // ubah nilai radius disini
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.grey, // warna border outline
              width: 1.0, // lebar border outline
            ),
          ),
        ),
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Cancel",
          style: TextStyle(
            fontSize: 12,
            color: GlobalColors.textPrimaryColor,
          ),
        ),
      ),
    );
  }
}
