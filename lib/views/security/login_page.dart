import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mca_leads_management_mobile/models/interfaces/admin_interface.dart';
import 'package:mca_leads_management_mobile/utils/theme/app_colors.dart';
import 'package:mca_leads_management_mobile/widgets/common/notifications.dart';

import '../../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color switch1Color = const Color(0xff24485e);
  bool isShowPassword = false;
  bool isKeepMeLogIn = false;
  String username = "";
  String password = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [header(), loginPart()],
      ),
    ));
  }

  Widget loginPart() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: AppColors.mystique, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.person,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: usernameController,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          username = value;
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          hintText: "Username",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      child: username.isEmpty
                          ? const SizedBox(
                              height: 24.0,
                              width: 24.0,
                            )
                          : Container(
                              color: Colors.black,
                              height: 24.0,
                              width: 24.0,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: AppColors.mystique, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.lock,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordController,
                        obscureText: !isShowPassword,
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: "password",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        isShowPassword
                            ? CupertinoIcons.eye_slash_fill
                            : CupertinoIcons.eye_fill,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isKeepMeLogIn = !isKeepMeLogIn;
                    });
                  },
                  child: _customCheckBox(),
                ),
                const SizedBox(
                  width: 4.0,
                ),
                const Text(
                  "Keep me logged in",
                  style: TextStyle(
                      color: AppColors.silverChalice,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Text(
                  "Forgot password ?",
                  style: TextStyle(
                      color: AppColors.silverChalice,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            _button(
                text: "LOGIN",
                backgroundColor: AppColors.alizarinCrimson,
                onTap: handleLogin),
          ],
        ),
      ),
    );
  }

  static Widget _button(
      {var text, var backgroundColor, VoidCallback? onTap, var textColor}) {
    textColor = textColor ?? Colors.white;
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: backgroundColor),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customCheckBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.gallery,
      ),
      height: 20.0,
      width: 20.0,
      child: Center(
        child: Icon(
          Icons.check,
          color: isKeepMeLogIn ? Colors.red : Colors.transparent,
          size: 16.0,
        ),
      ),
    );
  }

  Widget header() {
    return Stack(
      children: [
        Container(
          height: 360.0,
          decoration: const BoxDecoration(
          //     image: DecorationImage(
          //   // image: AssetImage(AppImages.carBackground),
          //   fit: BoxFit.cover,
          // )
          ),
        ),
        Container(
          color: Colors.black.withOpacity(1.0),
        ),
        Container(
        //     child: Center(
        //         child: Image.asset(
        //   AppImages.logo,
        //   height: 360.0,
        //   width: 140.0,
        //   color: Colors.white,
        // ))
        ),
      ],
    );
  }

  void handleLogin() async {
    var username = usernameController.text;
    var password = passwordController.text;

    if (username.isEmpty) {
      showSnackBar(text: "username can not be empty", context: context);
      return;
    }
    if (password.isEmpty) {
      showSnackBar(text: "password can not be empty", context: context);
      return;
    }
    AppResp response = await LoginController()
        .loginWithUsernameAndPassword(username, password);
    if (response.statusCode != HttpStatus.ok) {
      SnackBar snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message ?? "Username or Password incorrect"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
